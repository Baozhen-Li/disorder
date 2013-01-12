%--------------------------------------------------------------------------
%x0
%--------------------------------------------------------------------------
addpath('/home/jason/disorder/matlab/')
str.main = '/home/jason/disorder2/lj/amor/4x/prepare/tmp_lowTanneal/XCORR_AF/timeavg/5K/stiff/';
name = 'x0.data';
x0 = m_x0_read( strcat(str.main , name) );
%--------------------------------------------------------------------------
%lj
%--------------------------------------------------------------------------
x0.lj = m_lj;
%--------------------------------------------------------------------------
%constant
%--------------------------------------------------------------------------
x0.constant = m_constant;
%--------------------------------------------------------------------------
%alloy
%--------------------------------------------------------------------------
mass(1) = 1.0; mass(2) = 3.0;
	I = find(x0.m ==1); x0.m(I) = mass(1);
	I = find(x0.m ==2); x0.m(I) = mass(2);
%--------------------------------------------------------------------------
%af
%--------------------------------------------------------------------------
[AF.freq AF.Di AF.kappa ] =...
    m_af_lj( x0 , 1.0 , str.main , 'true' );







