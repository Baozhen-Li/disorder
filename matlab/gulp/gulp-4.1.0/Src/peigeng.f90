  subroutine peigeng(mcv,freq,ncore,nphonatc,ncfoc,iocptr,maxd2,eigr,leig,oscstrength)
!
!  Output quantities relating to the frequencies / intensities DOS for vibration.
!
!  Gamma point only version of peigen !!
!
!  Channel 59 is used to save the project densities of states
!
!   6/95 Intensities corrected by division by sqrt of mass
!   3/97 Correction added for partial occupancies
!   3/97 Imaginary eigenvectors now zerod at gamma point
!   9/97 Raman intensities added
!  11/97 Eigenvector range for printing added
!   5/98 Normalisation of eigenvectors removed as the values
!        return are already normalised
!   2/00 Normalisation added back as it appears that eispack
!        fails to ensure this after all!
!   6/00 itmp,w1,w2,w3 made local to this routine
!   3/02 w3 renamed to ir/raman
!   3/02 Calculation of eigenvalues/vectors removed to a
!        separate routine
!   3/02 Lower option removed to separate routine
!  11/02 Cartesian components of intensity added
!   5/06 Mass now uses species values
!   6/09 PDF modifications added
!   6/12 nsfoc removed from arguments as it is not used
!   7/12 New method for computing IR intensities based on Born
!        effective charges added
!   7/12 Oscillator strengths now passed in for IR intensity calculation
!   8/12 Missing assignment of trmj value in new algorthm added
!
!  Conditions of use:
!
!  GULP is available free of charge to academic institutions
!  and non-commerical establishments only. Copies should be
!  obtained from the author only and should not be distributed
!  in any form by the user to a third party without the express
!  permission of the author. This notice applies to all parts
!  of the program, except any library routines which are
!  distributed with the code for completeness. All rights for
!  such routines remain with the original distributor.
!
!  No claim is made that this program is free from errors and
!  no liability will be accepted for any loss or damage that
!  may result. The user is responsible for checking the validity
!  of their results.
!
!  Copyright Curtin University 2012
!
!  Julian Gale, NRI, Curtin University, August 2012
!
  use configurations
  use constants
  use control
  use current
  use element
  use general,        only : nwarn
  use iochannels
  use m_pdfneutron
  use parallel
  use projectdos
  use species
  implicit none
!
!  Passed variables
!
  integer(i4), intent(in)                      :: iocptr(*)
  integer(i4), intent(in)                      :: maxd2
  integer(i4), intent(in)                      :: mcv
  integer(i4), intent(in)                      :: ncore
  integer(i4), intent(in)                      :: ncfoc
  integer(i4), intent(in)                      :: nphonatc
  real(dp),    intent(in)                      :: eigr(maxd2,*)
  real(dp),    intent(in)                      :: freq(*)
  real(dp),    intent(in)                      :: oscstrength(3,3,mcv)
  logical,     intent(in)                      :: leig
!
!  Local variables
!
  integer(i4)                                  :: i
  integer(i4)                                  :: igroup
  integer(i4)                                  :: ii
  integer(i4)                                  :: inat
  integer(i4)                                  :: ind
  integer(i4)                                  :: indi
  integer(i4)                                  :: indj
  integer(i4)                                  :: iresid
  integer(i4), dimension(:), allocatable       :: itmp
  integer(i4)                                  :: itype
  integer(i4)                                  :: ix
  integer(i4)                                  :: iy
  integer(i4)                                  :: iz
  integer(i4)                                  :: j
  integer(i4)                                  :: k
  integer(i4)                                  :: l
  integer(i4)                                  :: m
  integer(i4)                                  :: natj
  integer(i4)                                  :: np
  integer(i4)                                  :: npc
  integer(i4)                                  :: npfirst
  integer(i4)                                  :: npi
  integer(i4)                                  :: npifirst
  integer(i4)                                  :: npilast
  integer(i4)                                  :: nplast
  integer(i4)                                  :: npout
  integer(i4)                                  :: nproj
  integer(i4)                                  :: nrell
  integer(i4)                                  :: nsj
  integer(i4)                                  :: ntj
  integer(i4)                                  :: status
  logical                                      :: lfound
  logical                                      :: lnofreq
  logical                                      :: lout
  logical                                      :: lproj
  real(dp)                                     :: cmfact
  real(dp)                                     :: ffact
  real(dp),    dimension(:), allocatable       :: ir
  real(dp),    dimension(:), allocatable       :: irx
  real(dp),    dimension(:), allocatable       :: iry
  real(dp),    dimension(:), allocatable       :: irz
  real(dp)                                     :: qj
  real(dp),    dimension(:), allocatable       :: raman
  real(dp)                                     :: rmnx
  real(dp)                                     :: rmny
  real(dp)                                     :: rmnz
  real(dp)                                     :: rkt
  real(dp)                                     :: trmj
  real(dp)                                     :: w
  real(dp),    dimension(:), allocatable       :: w1
  real(dp),    dimension(:), allocatable       :: w2
  real(dp)                                     :: xir
  real(dp)                                     :: yir
  real(dp)                                     :: zir
!
  lnofreq = (.not.lfreqout)
  lout = (leigen.and.ioproc.and.lfreqout)
  lproj = ((nprojcfg(ncf)-nprojdef(ncf)).gt.0)
!***************************
!  Output of eigenvectors  *
!***************************
  if (leig) then
    do m = 1,mcv
      write(53,'(''Mode '',i6)') m
      write(53,'(f15.6)') freq(m)
      ii = 0
      do i = 1,nphonatc
        write(53,'(3f10.6)') (eigr(ii+j,m),j=1,3)
        ii = ii + 3
      enddo
    enddo
  endif
!**********************************
!  Projected densities of states  *
!**********************************
  if (lproj) then
!
!  Loop over projections
!
    nproj = nprojcfg(ncf)
    npfirst = 1
    npifirst = 1
    ii = 0
    do i = 1,ncf-1
      npc = nprojcfg(i)
      npfirst = npfirst + npc
      do j = 1,npc
        npifirst = npifirst + nprojit(ii+j)
      enddo
      ii = ii + npc
    enddo
    nplast = npfirst + nproj - 1
    npilast = npifirst
    do i = 1,nproj
      npilast = npilast + nprojit(ii+i)
    enddo
    npilast = npilast - 1
    allocate(itmp(nasym),stat=status)
    if (status/=0) call outofmemory('peigeng','itmp')
    do np = npfirst,nplast
      if (nprojdb(np).eq.1) then
        do i = 1,nasym
          itmp(i) = 0
        enddo
!
!  Find atoms of projection
!
        do npi = npifirst,npilast
          if (nprojptr(npi).eq.np) then
            if (nprojtyp(npi).gt.99) then
              itmp(nprojnat(npi)) = 1
            else
              inat = nprojnat(npi)
              itype = nprojtyp(npi)
              do i = 1,nasym
                if (inat.eq.iatn(i).and.(itype.eq.natype(i).or.itype.eq.0)) itmp(i) = 1
              enddo
            endif
          endif
        enddo
!
!  Loop over frequencies
!
        do j = 1,mcv
          w = 0.0_dp
          ind = 0
!
!  Loop over atoms
!
          do k = 1,ncfoc
            lfound = .false.
            l = 1
            do while (l.le.ncore.and..not.lfound)
              if (iocptr(l).eq.k) then
                nrell = nrelat(l)
                if (itmp(nrell).eq.1) then
                  lfound = .true.
                  w = w + eigr(ind+1,j)**2 + eigr(ind+2,j)**2 + eigr(ind+3,j)**2
                endif
              endif
              l = l + 1
            enddo
            ind = ind + 3
          enddo
          if (ioproc) write(59) w
        enddo
      endif
    enddo
    deallocate(itmp,stat=status)
    if (status/=0) call deallocate_error('peigen','itmp')
  endif
!***********************************
!  Evaluate infra-red intensities  *
!***********************************
!
!  Only meaningful near gamma-point and hence
!  only the real eigenvectors are considered.
!
  allocate(ir(mcv),stat=status)
  if (status/=0) call outofmemory('peigeng','ir')
  allocate(irx(mcv),stat=status)
  if (status/=0) call outofmemory('peigeng','irx')
  allocate(iry(mcv),stat=status)
  if (status/=0) call outofmemory('peigeng','iry')
  allocate(irz(mcv),stat=status)
  if (status/=0) call outofmemory('peigeng','irz')
  allocate(raman(mcv),stat=status)
  if (status/=0) call outofmemory('peigeng','raman')
  if (linten.or.lout) then
    allocate(w1(ncfoc),stat=status)
    if (status/=0) call outofmemory('peigeng','w1')
    allocate(w2(3*ncfoc),stat=status)
    if (status/=0) call outofmemory('peigeng','w2')
    if (loldinten) then
!
!  Old method
!
      do i = 1,ncfoc
        w1(i) = 0.0_dp
        ix = 3*(i-1) + 1
        iy = ix + 1
        iz = ix + 2
        w2(ix) = 0.0_dp
        w2(iy) = 0.0_dp
        w2(iz) = 0.0_dp
        do j = 1,ncore
          if (iocptr(j).eq.i) then
            qj = qf(j)
            natj = nat(j)
            ntj = nftype(j)
            nsj = nspecptr(nrelat(j))
!
!  Add on any shell charge
!
            do k = 1,nspec
              if ((natspec(k)-maxele).eq.natj) then
                if (ntj.eq.ntypspec(k).or.ntypspec(k).eq.0) then
                  qj = qj + qlspec(k)
                endif
              endif
            enddo
            trmj = occuf(j)/sqrt(massspec(nsj))
!
!  Term for IR
!
            w1(i) = w1(i) + qj*trmj
!
!  Term for Raman
!
            call ramantrm(j,rmnx,rmny,rmnz)
            w2(ix) = w2(ix) + rmnx*trmj
            w2(iy) = w2(iy) + rmny*trmj
            w2(iz) = w2(iz) + rmnz*trmj
          endif
        enddo
      enddo
!
!  Sum eigenvector components multiplied by charge
!
      rkt = boltz*temperature
      if (abs(rkt).gt.1.0d-12) then
        cmfact = planck*speedl/rkt
      endif
      do i = 1,mcv
        xir = 0.0_dp
        yir = 0.0_dp
        zir = 0.0_dp
        raman(i) = 0.0_dp
        ind = 0
        do j = 1,ncfoc
          xir = xir + w1(j)*eigr(ind+1,i)
          yir = yir + w1(j)*eigr(ind+2,i)
          zir = zir + w1(j)*eigr(ind+3,i)
          raman(i) = raman(i) + w2(ind+1)*eigr(ind+1,i) + w2(ind+2)*eigr(ind+2,i) + w2(ind+3)*eigr(ind+3,i)
          ind = ind + 3
        enddo
        ir(i)  = xir*xir + yir*yir + zir*zir
        irx(i) = xir*xir
        iry(i) = yir*yir
        irz(i) = zir*zir
!
!  Scale Raman intensity by frequency factor
!
        if (abs(rkt).gt.1.0d-12) then
          ffact = 1.0_dp+1.0_dp/(exp(abs(freq(i))*cmfact)-1.0_dp)
        else
          ffact = 1.0_dp
        endif
        if (abs(freq(i)).gt.1.0_dp) then
          ffact = ffact*1000.0_dp/abs(freq(i))
        else
          ffact = 0.0_dp
        endif
        raman(i) = raman(i)*raman(i)*ffact
      enddo
    else
!
!  New algorithm
!
      do i = 1,ncfoc
        ix = 3*(i-1) + 1
        iy = ix + 1
        iz = ix + 2
        w2(ix) = 0.0_dp
        w2(iy) = 0.0_dp
        w2(iz) = 0.0_dp
        do j = 1,ncore
          if (iocptr(j).eq.i) then
            nsj = nspecptr(nrelat(j))
            trmj = occuf(j)/sqrt(massspec(nsj))
!
!  Term for Raman
!
            call ramantrm(j,rmnx,rmny,rmnz)
            w2(ix) = w2(ix) + rmnx*trmj
            w2(iy) = w2(iy) + rmny*trmj
            w2(iz) = w2(iz) + rmnz*trmj
          endif
        enddo
      enddo
!
!  Sum eigenvector components multiplied by charge
!
      rkt = boltz*temperature
      if (abs(rkt).gt.1.0d-12) then
        cmfact = planck*speedl/rkt
      endif
      do i = 1,mcv
        xir = 0.0_dp
        yir = 0.0_dp
        zir = 0.0_dp
        raman(i) = 0.0_dp
        ind = 0
        do j = 1,ncfoc
          xir = xir + w1(j)*eigr(ind+1,i)
          yir = yir + w1(j)*eigr(ind+2,i)
          zir = zir + w1(j)*eigr(ind+3,i)
          raman(i) = raman(i) + w2(ind+1)*eigr(ind+1,i) + w2(ind+2)*eigr(ind+2,i) + w2(ind+3)*eigr(ind+3,i)
          ind = ind + 3
        enddo
        ir(i)  = oscstrength(1,1,i) + oscstrength(2,2,i) + oscstrength(3,3,i)
        irx(i) = oscstrength(1,1,i)
        iry(i) = oscstrength(2,2,i)
        irz(i) = oscstrength(3,3,i)
!
!  Scale Raman intensity by frequency factor
!
        if (abs(rkt).gt.1.0d-12) then
          ffact = 1.0_dp+1.0_dp/(exp(abs(freq(i))*cmfact)-1.0_dp)
        else
          ffact = 1.0_dp
        endif
        if (abs(freq(i)).gt.1.0_dp) then
          ffact = ffact*1000.0_dp/abs(freq(i))
        else
          ffact = 0.0_dp
        endif
        raman(i) = raman(i)*raman(i)*ffact
      enddo
    endif
    deallocate(w2,stat=status)
    if (status/=0) call deallocate_error('peigeng','w2')
    deallocate(w1,stat=status)
    if (status/=0) call deallocate_error('peigeng','w1')
  endif
!************************
!  Output eigenvectors  *
!************************
  npout = mcv
  if (neiglow(ncf).ne.0) then
    if (neighigh(ncf).ne.0) then
      if (neighigh(ncf).gt.mcv) then
        nwarn = nwarn + 1
        call outwarning('Maximum eigenvector for printing exceeds number of modes',0_i4)
        neighigh(ncf) = mcv
      endif
      npout = neighigh(ncf) - neiglow(ncf) + 1
    else
      npout = 1
    endif
    indi = neiglow(ncf) - 1
  else
    indi = 0
  endif
  if (lout) then
    write(ioout,'(/,'' Frequencies (cm-1) and Eigenvectors : '',/)')
    if (ncfoc.ne.nphonatc) then
      write(ioout,'('' Note: eigenvectors in terms of reduced sites due to partial occupancies!'',/)')
    endif
    igroup = npout/6
    iresid = npout - igroup*6
    if (igroup.gt.0) then
      do i = 1,igroup
        write(ioout,'('' Frequency   '',6(f10.4))') (freq(indi+j),j=1,6)
        write(ioout,'('' IR Intensity'',6(f10.4))') (ir(indi+j),j=1,6)
        write(ioout,'(''    in X     '',6(f10.4))') (irx(indi+j),j=1,6)
        write(ioout,'(''    in Y     '',6(f10.4))') (iry(indi+j),j=1,6)
        write(ioout,'(''    in Z     '',6(f10.4))') (irz(indi+j),j=1,6)
        write(ioout,'('' Raman Intsty'',6(f10.4),/)') (raman(indi+j),j=1,6)
        indj = 0
        do j = 1,ncfoc
          write(ioout,'(i6,'' x '',4x,6f10.6)') j,(eigr(indj+1,indi+k),k=1,6)
          write(ioout,'(i6,'' y '',4x,6f10.6)') j,(eigr(indj+2,indi+k),k=1,6)
          write(ioout,'(i6,'' z '',4x,6f10.6)') j,(eigr(indj+3,indi+k),k=1,6)
          indj = indj + 3
        enddo
        indi = indi + 6
        write(ioout,'(/)')
      enddo
    endif
    if (iresid.gt.0) then
      write(ioout,'('' Frequency   '',6(f10.4))') (freq(indi+j),j=1,iresid)
      write(ioout,'('' IR Intensity'',6(f10.4))') (ir(indi+j),j=1,iresid)
      write(ioout,'(''    in X     '',6(f10.4))') (irx(indi+j),j=1,iresid)
      write(ioout,'(''    in Y     '',6(f10.4))') (iry(indi+j),j=1,iresid)
      write(ioout,'(''    in Z     '',6(f10.4))') (irz(indi+j),j=1,iresid)
      write(ioout,'('' Raman Intsty'',6(f10.4),/)') (raman(indi+j),j=1,iresid)
      indj = 0
      do j = 1,ncfoc
        write(ioout,'(i6,'' x '',4x,6f10.6)') j,(eigr(indj+1,indi+k),k=1,iresid)
        write(ioout,'(i6,'' y '',4x,6f10.6)') j,(eigr(indj+2,indi+k),k=1,iresid)
        write(ioout,'(i6,'' z '',4x,6f10.6)') j,(eigr(indj+3,indi+k),k=1,iresid)
        indj = indj + 3
      enddo
    endif
    write(ioout,'(/)')
  elseif (linten) then
    write(ioout,'(/,'' Frequencies (cm-1) and IR Intensities : '',/)')
    igroup = npout/6
    iresid = npout - igroup*6
    if (igroup.gt.0) then
      do i = 1,igroup
        write(ioout,'('' Frequency   '',6(f10.4))') (freq(indi+j),j=1,6)
        write(ioout,'('' IR Intensity'',6(f10.4))') (ir(indi+j),j=1,6)
        write(ioout,'(''    in X     '',6(f10.4))') (irx(indi+j),j=1,6)
        write(ioout,'(''    in Y     '',6(f10.4))') (iry(indi+j),j=1,6)
        write(ioout,'(''    in Z     '',6(f10.4))') (irz(indi+j),j=1,6)
        write(ioout,'('' Raman Intsty'',6(f10.4),/)') (raman(indi+j),j=1,6)
        indi=indi+6
      enddo
    endif
    if (iresid.gt.0) then
      write(ioout,'('' Frequency   '',6(f10.4))') (freq(indi+j),j=1,iresid)
      write(ioout,'('' IR Intensity'',6(f10.4))') (ir(indi+j),j=1,iresid)
      write(ioout,'(''    in X     '',6(f10.4))') (irx(indi+j),j=1,iresid)
      write(ioout,'(''    in Y     '',6(f10.4))') (iry(indi+j),j=1,iresid)
      write(ioout,'(''    in Z     '',6(f10.4))') (irz(indi+j),j=1,iresid)
      write(ioout,'('' Raman Intsty'',6(f10.4),/)') (raman(indi+j),j=1,iresid)
    endif
    write(ioout,'(/)')
  elseif (.not.lnofreq.and.ioproc) then
    write(ioout,'(/,'' Frequencies (cm-1) : '',/)')
    write(ioout,'(9(f8.2))') (freq(j),j=1,mcv)
    write(ioout,'(/)')
  endif
!
!  Setup eigenvectors for PDF
!
  if (lmakeeigarray) then
    call makeeigenarrays(eig_r=eigr,frequency=freq,m=maxd2)
  endif
!
  deallocate(raman,stat=status)
  if (status/=0) call deallocate_error('peigeng','raman')
  deallocate(irz,stat=status)
  if (status/=0) call deallocate_error('peigeng','irz')
  deallocate(iry,stat=status)
  if (status/=0) call deallocate_error('peigeng','iry')
  deallocate(irx,stat=status)
  if (status/=0) call deallocate_error('peigeng','irx')
  deallocate(ir,stat=status)
  if (status/=0) call deallocate_error('peigeng','ir')
!
  return
  end
