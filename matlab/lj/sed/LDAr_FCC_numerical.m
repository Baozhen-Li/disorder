function [freq,eigVsorted,velocity,dDdkx] = LDAr_FCC(alat,kappa)

%function LDAr_FCC

%Jason Larkin
%March 21, 2011
%MODIFICATIONS:
%1) March 21 2011: Added group velocity.

%-------------------------------------------------------
%-------------PROGRAM PARAMETERS------------------------
%-------------------------------------------------------
%Declare Global Variables
%ncell=10;                           %number of unit cells used in x,y,z
%N=2^(3*ncell-1);                   %number of atoms based on ncells

L(1,1:3)=zeros(1,3);                %contains the simulation cell size
pi = atan(1)*4;                     %contains value of pi, in C this would be pi = atan(1) * 4
%LJ Potential and Material Parameters
epsilon_Ar = 1.67E-21;              %aJ (1.67E-21 Joules) aJ=1E-18 J
sigma_Ar = 3.4E-10;                 %Angstroms 3.4E-10 meters
a_0 = 5.2686E-10/sigma_Ar;            %the lattice constant of Ar: http://www.infoplease.com/periodictable.php?id=18
mass_Ar = 6.6326E-26;               %1E-28 kg (6.6326E-26 kg)
%mass_Ar = mass_Ar/mass_Ar;
tau_Ar = sqrt((mass_Ar*(sigma_Ar^2))/epsilon_Ar);
kb = 1.3806E-23;                    %aJ/k (1.3806E-23 J/K)
hbar = 1.054E-34;                %J/s

%Main Arrays (M X N)
%x(1:N,1:3)=zeros(N,3);              %position
%m(1,1:N) = zeros(N,1);              %mass of the particle
%m(1,1:N) = 1; 
%ident_letter(1,1:N)=zeros(N,1);     %letter identifying the particle, e.g. C, N, etc.
rij(1,1:3)=0;                       %pairwise distance between atoms i and j
%F(1:N,1:3)=zeros(N,3);              %force on particle (1E-28 kg Anstromg/fs)

%RDF = zeros(5000,2);

V = 0; 
P_virial = 0;
P = 0;
%%%%%Cutoffs
a = 2.5;                            %Angstroms cutoff radius in terms of sigma_Ar 
a2 = a*a;
cutoff = 0;                         %true=1, use the cutoff radius. This of course introduces a discontinuity in the force at r=a
%Calculate Potential Energy cutoff value
pe_cutoff = pe(a2);
%Calculate Force Cutoff value
f_cutoff=force_eval(a2);

%Set initial conditions if the simulation is not a restart
RESTART=0;
%Set to run in NVE to initialize from 0 K state
rescale=0;

%-------------------------------------------------------
%------------Program------------------------------------
%-------------------------------------------------------

%1) read_data  
        x=[ 0.000000   0.000000   0.000000
            0.5000     0.5000     0.000000
            0.5000     0.000000   0.5000
            0.000000   0.5000     0.5000];
        
        m = [1.0 1.0 1.0 1.0];
        N = 4;
        x(:,1) = x(:,1)*alat(1); x(:,2) = x(:,2)*alat(2); x(:,3) = x(:,3)*alat(3);

        num_ucells = ceil(a/alat(1,1));
%2) Build up the unit cell images        
            [x_ucell, x_ucell2, cell_index] = build_ucells (x,alat,num_ucells);
%3) find initial forces/pressure
            V=alat(1,1)*alat(1,2)*alat(1,3);
%4) Calculate dynamical matrix 
            [D,dDdkx,dDdky,dDdkz] = dynam_matrix(a2,x,x_ucell,m,kappa);
%5) Calculate freqs, eigV, and v_g
            [eigV,W2]=eig(D); W=sqrt(W2);
%CREATE FREQ VECTOR          
            for i=1:length(W)
            w(i) = W(i,i);
            end   
%SORT FREQS AND EIGV
              [freq,I]=sort(abs(w));
              eigVsorted(1:3*N,1:3*N) = eigV(:,I);          
%CALCULATE VG
        for i1=1:length(freq)
            resultx = dDdkx*eigVsorted(:,i1);
            resulty = dDdky*eigVsorted(:,i1);
            resultz = dDdkz*eigVsorted(:,i1);
            
            answerx = dot(eigVsorted(:,i1), resultx);
            answery = dot(eigVsorted(:,i1), resulty);
            answerz = dot(eigVsorted(:,i1), resultz);
            
            velocity(i1,1) = answerx/(2*freq(i1));
            velocity(i1,2) = answery/(2*freq(i1));
            velocity(i1,3) = answerz/(2*freq(i1));
        end
          
          
   
                  

% 
%   toc      
%         for i=1:length(W)
%             w(i) = W(i,i);
%         end   
%         w_sort = sort(real(w));
%         
%         %Calculate DOS        
%         [DOS(:,2),DOS(:,1)] = hist(real(w),30);
% 
% %5) Calculate Participation Ratios
%         eps2(1:3*N)=0;
%         for i=1:1:3*N
%                 for j=1:3:3*N  
%                     eps2(i) = eps2(i) + (sum(conj(eigV(j:j+2,i)).*eigV(j:j+2,i)))^2;
%                 end
%                 p(i,1) = W(i,i);
%                 p(i,2) = 1/(N*eps2(i));
%         end
%         plot(real(p(:,1)),p(:,2),'.')
%   
%        str=strcat(str_main,'p.dat');
%        dlmwrite(str,real(p));
  
% %6) Calcualte mode weight factor
%         fweight(
%         for i=1:1:N
%                 for j=1:3:3*N  
%                     fweight(i) = fweight(i) + sum(eigV(j:j+2,i).^2);
%                 end
%                 p(i,1) = W(i,i);
%                 p(i,2) = 1/(N*eps2(i));
%         end
        
%7) Calculate mode polarization
%         pol(1:3*N,1:3*N)=0;
%         for i=1:1:3*N
%                 for j=1:3:3*N  
%                     pol(j:j+2,i) = eigV(j:j+2,i)/sum(conj(eigV(j:j+2,i)).*eigV(j:j+2,i));
%                 end
%         end
%         plot(pol)

 
    

%8) Calculate thermal diffusivity matrix

%         [diffx,diffy,diffz,diff] = therm_diff_5(D,eigV,W,PHI1,PHI2,PHI3,V,hbar,epsilon_Ar,tau_Ar,a2,x,x_ucell,m,[0.0,0.0,0.0]);              
%         diff = diff*(sigma_Ar^2)/tau_Ar;        
%         plot(w/tau_Ar,diff);       
%         therm_cond = sum(kb*diff)/((alat(1,1)*sigma_Ar)^3)
        
%         for i=1:3*N
%         str=strcat(str_main,'w.dat');
%         dlmwrite(str,real(w(i)),'-append','delimiter',' '); dlmwrite(str,imag(w(i)),'-append','delimiter',' ');
%         end

%Spit out "dynamical" matrix, eigvectors and frequencies
%         str=strcat(str_main,'w_real.dat');
%         dlmwrite(str,real(w),'delimiter',' ');
%         str=strcat(str_main,'w_imag.dat');
%         dlmwrite(str,imag(w),'delimiter',' ');
%         str=strcat(str_main,'w_sort.dat');
%         dlmwrite(str,real(w_sort),'delimiter',' ');
%         str=strcat(str_main,'DOS.dat');
%         dlmwrite(str,DOS,'delimiter',' ');
%         
%         str=strcat(str_main,'eigV_real.dat');
%         dlmwrite(str,real(eigV),'delimiter',' ');
%         str=strcat(str_main,'eigV_imag.dat');
%         dlmwrite(str,imag(eigV),'delimiter',' ');
%         
%         str=strcat(str_main,'PHI1_real.dat');
%         dlmwrite(str,real(PHI1),'delimiter',' ');
%         str=strcat(str_main,'PHI1_imag.dat');
%         dlmwrite(str,imag(PHI1),'delimiter',' ');
%         
%         str=strcat(str_main,'PHI2_real.dat');
%         dlmwrite(str,real(PHI2),'delimiter',' ');
%         str=strcat(str_main,'PHI2_imag.dat');
%         dlmwrite(str,imag(PHI2),'delimiter',' ');
%         
%         str=strcat(str_main,'PHI3_real.dat');
%         dlmwrite(str,real(PHI3),'delimiter',' ');
%         str=strcat(str_main,'PHI3_imag.dat');
%         dlmwrite(str,imag(PHI3),'delimiter',' ');




%--------------------------------------------------------------------------
%------------FUNCTIONS-----------------------------------------------------
%--------------------------------------------------------------------------


function [x_ucell,x_ucell2,index] = build_ucells (x,alat,num_cells)
% x_ucell = coordinates of the unit cell images
% index = number of unit cell images produced
    A = size(x);
    index=1;
    for i=-num_cells:1:num_cells   
    %for i=0:1:num_cells 
        for j=-num_cells:1:num_cells 
        %for j=0:1:num_cells 
            for k=-num_cells:1:num_cells
            %for k=0:1:num_cells
                x_ucell( ((index-1)*A(1,1)+1):((index)*A(1,1)) , 1 ) = x(:,1) + i*alat(1,1) ;
                x_ucell( ((index-1)*A(1,1)+1):((index)*A(1,1)) , 2 ) = x(:,2) + j*alat(1,2) ;
                x_ucell( ((index-1)*A(1,1)+1):((index)*A(1,1)) , 3 ) = x(:,3) + k*alat(1,3) ;
                x_ucell( ((index-1)*A(1,1)+1):((index)*A(1,1)) , 4 ) = index;
                index=index+1;
            end
        end
    end
    index=1;
    for i=0:num_cells    
        for j=0:num_cells        
            for k=0:num_cells
                x_ucell2( ((index-1)*A(1,1)+1):((index)*A(1,1)) , 1 ) = x(:,1) + i*alat(1,1) ;
                x_ucell2( ((index-1)*A(1,1)+1):((index)*A(1,1)) , 2 ) = x(:,2) + j*alat(1,2) ;
                x_ucell2( ((index-1)*A(1,1)+1):((index)*A(1,1)) , 3 ) = x(:,3) + k*alat(1,3) ;
                index=index+1;
            end
        end
    end
end

%--------------------------------------------------------------------------


function [D,dDdkx,dDdky,dDdkz,PHI1,PHI2,PHI3] = dynam_matrix(a2,x,x_ucell,m,kappa)
%FUNCTION: find dynamical matrix
%update: trying to get rid of C-style programing to speed up matlab
    %clear old force constants
    A=size(x); N=A(1,1); i=sqrt(-1);
    Phi(1:3,1:3)=0; D( 1:3*N, 1:3*N ) = 0; 
    dDdkx(1:3*N,1:3*N) = 0; dDdky(1:3*N,1:3*N) = 0; dDdkz(1:3*N,1:3*N) = 0;
    PHI1( 1:3*N, 1:3*N ) = 0; PHI2( 1:3*N, 1:3*N ) = 0; PHI3( 1:3*N, 1:3*N ) = 0;
    temp(1) = 0; temp2(1) = 0; temp3(1) = 0; temp4(1) = 0;
    %Rij(1:N,1:3,1:N)=0;
    
    for i1=1:N
        for i2=1:N        
            %k,k',m
            clear rij r2
            rij(length(x_ucell)/N,1:3)=0;
            rij(:,1) = x_ucell(i2:N:length(x_ucell),1) - x(i1,1);
            rij(:,2) = x_ucell(i2:N:length(x_ucell),2) - x(i1,2);
            rij(:,3) = x_ucell(i2:N:length(x_ucell),3) - x(i1,3);
            dot_product(:,1) = kappa(1)*rij(:,1) + kappa(2)*rij(:,2) + kappa(3)*rij(:,3); 
            invmexpikR = exp(-i*dot_product(:,1))*(1/sqrt(m(i1)*m(i2)));
            
            r2 = rij(:,1).^2 + rij(:,2).^2 + rij(:,3).^2;
            clear I
            [I] = find(r2<a2 & r2~=0); Isize = size(I); 
            for i3=1:Isize(1,1)
                Phi(1:3,1:3)=0;
                Phi = -1*(make_force_matrix(r2(I(i3)),rij(I(i3),1:3),rij(I(i3),1:3)));
                for i4=1:3
                    for i5=1:3   
                        temp = Phi(i4,i5)*invmexpikR(I(i3),1);
                        temp2 = temp*(i*rij(I(i3),1));
                        temp3 = temp*(i*rij(I(i3),2));
                        temp4 = temp*(i*rij(I(i3),3));
                        dDdkx( (i1-1)*3+i4, (i2-1)*3+i5 ) = dDdkx( (i1-1)*3+i4, (i2-1)*3+i5 ) +  temp2;
                        dDdky( (i1-1)*3+i4, (i2-1)*3+i5 ) = dDdky( (i1-1)*3+i4, (i2-1)*3+i5 ) +  temp3;
                        dDdkz( (i1-1)*3+i4, (i2-1)*3+i5 ) = dDdkz( (i1-1)*3+i4, (i2-1)*3+i5 ) +  temp4;  
                    end
                end
                D( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) = D( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) + Phi*exp(sqrt(-1)*dot(kappa,rij(I(i3),1:3)));
                PHI1( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) = PHI1( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) + (1/sqrt(m(i1)*m(i2)))*Phi*rij(I(i3),1);
                PHI2( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) = PHI2( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) + (1/sqrt(m(i1)*m(i2)))*Phi*rij(I(i3),2);
                PHI3( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) = PHI3( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) + (1/sqrt(m(i1)*m(i2)))*Phi*rij(I(i3),3);
            end
            %The self term
            if i1==i2
                clear rij r2
                rij(length(x_ucell),1:3)=0;
                rij(:,1) = x_ucell(:,1) - x(i1,1); rij(:,2) = x_ucell(:,2) - x(i1,2); rij(:,3) = x_ucell(:,3) - x(i1,3);
                r2 = rij(:,1).^2 + rij(:,2).^2 + rij(:,3).^2;
                clear I
                [I] = find(r2<a2 & r2~=0); Isize = size(I); Phi(1:3,1:3)=0;
                for i3=1:Isize(1,1)
                    Phi = Phi + (make_force_matrix(r2(I(i3)),rij(I(i3),1:3),rij(I(i3),1:3)));
                end
                D( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) = D( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) + Phi;
            end
            D( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 ) = ( (1/sqrt((m(i1)*m(i2)))) )*D( 1+(i1-1)*3:3*i1, 1+(i2-1)*3:3*i2 );
        end
    end
end
   
%-------------------------------------------------------------------------- 
    
    function [Phi] = make_force_matrix(r2,ralpha,rbeta)
        
        h = 0.005;
        
         
         for i=1:3
             for j=1:3
                 rij = ralpha;
                 rij(i) = rij(i) + h;
                 r2 = rij(1,1)^2 + rij(1,2)^2 + rij(1,3)^2;
                 f1=first_deriv(r2);
                 F1 = rij(j)*f1;
                 rij(i) = rij(i) - 2*h;
                 r2 = rij(1,1)^2 + rij(1,2)^2 + rij(1,3)^2;
                 f2=first_deriv(r2); 
                 F2 = rij(j)*f2;
                 Phi(i,j) = (F2-F1)/2*h;
             end
         end
         

    end

%     function [Phi] = make_force_matrix_self(r2,ralpha,rbeta)
%          
%         h = 0.005;
%         
%          phi1 = first_deriv(r2);
%          phi2 = second_deriv(r2);  
%          
%          
%          
%              for j=1:3
%                  if i==j
%                     Phi(i,j) =  (ralpha(1,i)*rbeta(1,j)/r2)*(phi2 - phi1) + phi1; 
%                  else
%                     Phi(i,j) =  (ralpha(1,i)*rbeta(1,j)/r2)*(phi2 - phi1);
%                  end
%              end
%     end
    
%--------------------------------------------------------------------------

function f=first_deriv(r2)
%FUNCTION: evaluate magnitude of the force for given separation r2
    %using the method derived here:
    %http://www.pages.drexel.edu/~cfa22/msim/node36.html
    r4 = r2*r2; r8 = r4*r4; r14i = 1/(r8*r4*r2);
    f = -48*r14i + 24*r4*r2*r14i;
end

%--------------------------------------------------------------------------

function f=second_deriv(r2)
%FUNCTION: evaluate magnitude of the force for given separation r2
    %using the method derived here:
    %http://www.pages.drexel.edu/~cfa22/msim/node36.html
    r4 = r2*r2; r8 = r4*r4; r14i = 1/(r8*r4*r2);
    f = (4*156)*r14i - (42*4)*r4*r2*r14i;
end

end
