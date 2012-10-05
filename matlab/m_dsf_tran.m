
function DSF =...
    m_dsf_tran( str , kpt , x0 , freqp, eigvec, alat , DW_SCALE , MAX_FREQ_SCALE )
%M_DSF_LONG
%	DSF =...
%   m_dsf_tran( str , kpt , x0 , freqp, eigvec, alat , DW_SCALE , MAX_FREQ_SCALE )
%	
%	kpt is expected to have form:
%
%	kpt(:,1) = 0...0.5
%	x0(:,1)==atomid, x0(:,2)==typeid, x0(:,3:5)=xyz
%	freq(1:NUM_MODES)
%	eigvec(3*NUM_ATOMS,NUM_MODES)
%--------------------------------------------------------------------------
tic
%--------------------------------------------------------------------------

lj = m_lj; constant = m_constant;
%scale by lattice constant
KX = kpt(:,1)/alat;
KY = kpt(:,2)/alat;
KZ = kpt(:,3)/alat;

KXhat = KX'./sqrt(KX'.^2+KY'.^2+KZ'.^2 );
KYhat = KY'./sqrt(KX'.^2+KY'.^2+KZ'.^2 );
KZhat = KZ'./sqrt(KX'.^2+KY'.^2+KZ'.^2 );

spatial =...
    bsxfun( @times , x0.x , KX' ) +...
    bsxfun( @times , x0.y , KY' ) +...
    bsxfun( @times , x0.z , KZ' );

for imode = 1:size(freqp,1)
%KY*eigz - KZ*eigy
eig_fftx(imode,1:size(kpt,1)) =...
    sum(...
        bsxfun(@times,...
            bsxfun(@times,eigvec(3:3:size(eigvec,1),imode),KYhat) - ...
            bsxfun(@times,eigvec(2:3:size(eigvec,1),imode),KZhat),...
            exp( 2*pi*1i*( spatial ))...
        )...
    ,1);
%KZ*eigx - KX*eigz
eig_ffty(imode,1:size(kpt,1)) =...
    sum(...
        bsxfun(@times,...
            bsxfun(@times,eigvec(1:3:size(eigvec,1),imode),KZhat) - ...
            bsxfun(@times,eigvec(3:3:size(eigvec,1),imode),KXhat),...
            exp( 2*pi*1i*( spatial ))...
        )...
    ,1);
%KX*eigy - KY*eigx
eig_fftz(imode,1:size(kpt,1)) =...
    sum(...
        bsxfun(@times,...
            bsxfun(@times,eigvec(1:3:size(eigvec,1),imode),KZhat) - ...
            bsxfun(@times,eigvec(3:3:size(eigvec,1),imode),KXhat),...
            exp( 2*pi*1i*( spatial ))...
        )...
    ,1);

EpL(imode,:) =...
    real(eig_fftx(imode,:)).^2 + imag(eig_fftx(imode,:)).^2 +...
    real(eig_ffty(imode,:)).^2 + imag(eig_ffty(imode,:)).^2 +...
    real(eig_fftz(imode,:)).^2 + imag(eig_fftz(imode,:)).^2 ; 

%--------------------------------------------------------------------------
%pause
%--------------------------------------------------------------------------
end

DSF.EpL = EpL;

DSF.freq_range = linspace( 0 , max(freqp)*MAX_FREQ_SCALE , size(freqp,1) );
%find mean level spacing
freq_sorted = sort(freqp);
dw_avg =...
    real(...
    mean(...
    freq_sorted(2:length(freq_sorted))...
    -...
    freq_sorted(1:length(freq_sorted)-1)));

for imode = 1:size(freqp,1)

%find lorentzian broadenings
delwij = ...
    freqp - DSF.freq_range(imode);
lor =...
    (1.0/pi)*(dw_avg*DW_SCALE./(delwij.^2+(dw_avg*DW_SCALE)^2));

SL(imode,:) = ...
    sum(...
    bsxfun(@times,...
        EpL(:,:) , lor...
    ),...
    1);

end

DSF.kpt = kpt;
DSF.SL = SL;
DSF.freqp = freqp;

save(strcat(str,'DSF_tran.mat'), '-struct', 'DSF');
%--------------------------------------------------------------------------
toc
%--------------------------------------------------------------------------
end