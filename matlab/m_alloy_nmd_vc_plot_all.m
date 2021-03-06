%function m_ald_taud_nmd_mix(str_ald,str_nmd_per,str_nmd_vc,str_alloy)
%--------------------------------------------------------------------------
%m_ald_taud(str_ald,str_nmd_perfect,str_nmd_vc,str_alloy)
% m_ald_taud(...
% '/home/jason/disorder/lj/ald/m1.1/10x/Data_fullBZ.xls',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/')
%--------------------------------------------------------------------------

str_ald = '/home/jason/disorder2/lj/ald/m1.1/10x/Data_fullBZ.xls';
str_nmd_per = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
str_nmd_vc = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/';
str_nmd_af = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD_AF/1/work/';
str_alloy = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';

lj = m_lj; constant = m_constant;

ald = m_joe_read_data(str_ald);

nmd_per=load(strcat(str_nmd_per,'NMDdata.mat'));
sed_per=load(strcat(str_nmd_per,'SEDdata.mat'));
sed_per = nmd_convert_data(nmd_per,sed_per)

nmd_vc=load(strcat(str_nmd_vc,'NMDdata.mat'));
sed_vc=load(strcat(str_nmd_vc,'SEDdata.mat'));
sed_vc = nmd_convert_data(nmd_vc,sed_vc)

sed_per.ald = m_joe_ald2nmd( nmd_per , ald );

alloy = load(strcat(str_alloy,'ALLOY.mat'));

nmd_af=load(strcat(str_nmd_af,'NMDfit_orig.mat'));
sed_af=load(strcat(str_nmd_af,'SEDfit_orig.mat'));


loglog(...
    alloy.freq,alloy.life,'.'...
    )

%nmd_per vs nmd_vc
loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )

%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 

%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------
%NMD VC CHANGES
%-------------------------------------------------------------------------- 
%-------------------------------------------------------------------------- 
%1
reso = 0.01;
[I,J] = find(...
    6.3 - reso < sed_vc.life & sed_vc.life < 14.0 + reso &...
    4.177 - reso < sed_vc.freq & sed_vc.freq < 4.093 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.8;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%2
reso = 0.01;
[I,J] = find(...
    2.6 - reso < sed_vc.life & sed_vc.life < 14.5 + reso &...
    4.25 - reso < sed_vc.freq & sed_vc.freq < 8.338 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.8;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%3
reso = 0.01;
[I,J] = find(...
    26.0 - reso < sed_vc.life & sed_vc.life < 32.0 + reso &...
    1.73 - reso < sed_vc.freq & sed_vc.freq < 2.0 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*1.5;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%4
reso = 0.01;
[I,J] = find(...
    3.18 - reso < sed_vc.life & sed_vc.life < 7.826 + reso &...
    4.73 - reso < sed_vc.freq & sed_vc.freq < 6.274 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.8;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%5
reso = 0.01;
[I,J] = find(...
    35.41 - reso < sed_vc.life & sed_vc.life < 35.41 + reso &...
    2.605 - reso < sed_vc.freq & sed_vc.freq < 2.605 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*1.25;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%6
reso = 0.01;
[I,J] = find(...
    6.26 - reso < sed_vc.life & sed_vc.life < 14.3 + reso &...
    3.45 - reso < sed_vc.freq & sed_vc.freq < 4.73 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.8;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%7
reso = 0.01;
[I,J] = find(...
    1.701 - reso < sed_vc.life & sed_vc.life < 2.628 + reso &...
    16.87 - reso < sed_vc.freq & sed_vc.freq < 18.2 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.4;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%8
reso = 0.01;
[I,J] = find(...
    7.082 - reso < sed_vc.freq ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.75;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 

plot(...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),...
    sed_vc.life,'.',...
    sed_vc.life,sed_vc.life...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 

%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------
%NMD VC CHANGES
%-------------------------------------------------------------------------- 
%-------------------------------------------------------------------------- 


%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------
%NMD AF CHANGES
%-------------------------------------------------------------------------- 
%-------------------------------------------------------------------------- 
%1
reso = 0.01;
reso2 = 0.5;
[I,J] = find(...
    30.27 - reso < sed_af.life & sed_af.life < 200 + reso &...
    3.9 - reso < sed_af.HLDfreq & sed_af.HLDfreq < 21.41 + reso ...
    );
%sed_af.life(J) = sed_af.life(J)*(1/17);
for ifreq = 1:length(J)
    [I2,J2] = find(...
    sed_af.HLDfreq(J(ifreq)) - reso2 < sed_af.HLDfreq(J(ifreq)) &...
    sed_af.HLDfreq(J(ifreq)) < sed_af.HLDfreq(J(ifreq)) + reso2 ...
    );
sed_af.life(J(ifreq)) = mean(sed_af.life(J2));
end

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%2
reso = 0.01;
reso2 = 0.5;
[I,J] = find(...
    15.0 - reso < sed_af.life & sed_af.life < 180.0 + reso &...
    15.0 - reso < sed_af.HLDfreq & sed_af.HLDfreq < 25.0 + reso ...
    );
%sed_af.life(J) = sed_af.life(J)*(1/17);
for ifreq = 1:length(J)
    [I2,J2] = find(...
    sed_af.HLDfreq(J(ifreq)) - reso2 < sed_af.HLDfreq(J(ifreq)) &...
    sed_af.HLDfreq(J(ifreq)) < sed_af.HLDfreq(J(ifreq)) + reso2 ...
    );
sed_af.life(J(ifreq)) = mean(sed_af.life(J2));
end

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )
%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%3
reso = 0.01;
[I,J] = find(...
    1.521 - reso < sed_af.life & sed_af.life < 4.5 + reso &...
    16.19 - reso < sed_af.HLDfreq & sed_af.HLDfreq < 25.0 + reso ...
    );
sed_af.life(J) = sed_af.life(J)*0.6;

loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    sed_per.ald.freq,sed_per.ald.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )


%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------
%NMD AF CHANGES
%-------------------------------------------------------------------------- 
%-------------------------------------------------------------------------- 

cond_vc =...
    m_ald_cond(...
    sed_vc.life*lj.tau,...
    sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME)

cond_ald =...
    m_ald_cond(...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
    sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME)

%compare gamma and vc
loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    0.95*sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )

m_nmd_modify_c05_gamma_createfigure(...
    sed_vc.freq,...
    sed_vc.life,...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),...
    0.95*sed_af.HLDfreq,...
    sed_af.life,...
    sed_per.ald.freq,...
    2*pi./sed_per.ald.freq,...
    sed_per.ald.freq,...
    1E4*(1./(sed_per.ald.freq.^4)),...
    sed_per.ald.freq,...
    1E3*(1./(sed_per.ald.freq.^2))...
    )

save(strcat(str_nmd_vc,'NMDdata.mat'), '-struct', 'nmd_vc');
save(strcat(str_nmd_vc,'SEDdata.mat'), '-struct', 'sed_vc');

save(strcat(str_nmd_af,'NMDdata.mat'), '-struct', 'nmd_af');
save(strcat(str_nmd_af,'SEDdata.mat'), '-struct', 'sed_af');


%end