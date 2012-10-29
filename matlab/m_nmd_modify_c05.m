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

nmd_vc=load(strcat(str_nmd_vc,'NMDdata_orig.mat'));
sed_vc=load(strcat(str_nmd_vc,'SEDdata_orig.mat'));
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
    18.68 - reso < sed_vc.life & sed_vc.life < 18.68 + reso &...
    2.671 - reso < sed_vc.freq & sed_vc.freq < 2.671 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*1.15;

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
%2
reso = 0.01;
[I,J] = find(...
    26.43 - reso < sed_vc.life & sed_vc.life < 26.43 + reso &...
    2.339 - reso < sed_vc.freq & sed_vc.freq < 2.339 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*1.1;

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
%3
reso = 0.01;
[I,J] = find(...
    5.4 - reso < sed_vc.life & sed_vc.life < 10.94 + reso &...
    4.663 - reso < sed_vc.freq & sed_vc.freq < 6.394 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.7;

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
%4
reso = 0.01;
[I,J] = find(...
    2.085 - reso < sed_vc.life & sed_vc.life < 3.007 + reso &...
    6.649 - reso < sed_vc.freq & sed_vc.freq < 7.555 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.7;

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
%5
reso = 0.01;
[I,J] = find(...
    2.629 - reso < sed_vc.life & sed_vc.life < 2.629 + reso &...
    7.023 - reso < sed_vc.freq & sed_vc.freq < 7.023 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.75;

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
%6
reso = 0.01;
[I,J] = find(...
    0.5533 - reso < sed_vc.life & sed_vc.life < 0.941 + reso &...
    8.192 - reso < sed_vc.freq & sed_vc.freq < 9.136 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*1.15;

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
%7
reso = 0.01;
[I,J] = find(...
    13.43 - reso < sed_vc.freq ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.8;


%--------------------------------------------------------------------------
pause
%-------------------------------------------------------------------------- 
%8
reso = 0.01;
[I,J] = find(...
    7.416 - reso < sed_vc.life & sed_vc.life < 7.416 + reso &...
    11.27 - reso < sed_vc.freq & sed_vc.freq < 11.27 + reso ...
    );
sed_vc.life(I) = sed_vc.life(I)*0.3;


loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )

m_nmd_modify_c05_createfigure(...
    sed_vc.freq,...
    sed_vc.life,...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),... 
    sed_per.ald.freq,...
    2*pi./sed_per.ald.freq...
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
sed_af.life = sed_af.life*0.75;

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
[I,J] = find(...
    0.4664 - reso < sed_af.life & sed_af.life < 2.258 + reso &...
    9.937 - reso < sed_af.HLDfreq & sed_af.HLDfreq < 12.47 + reso ...
    );
sed_af.life(J) = sed_af.life(J)*2;

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
    1.248 - reso < sed_af.life & sed_af.life < 9.188 + reso &...
    14.48 - reso < sed_af.HLDfreq & sed_af.HLDfreq < 25.71 + reso ...
    );
sed_af.life(J) = sed_af.life(J)*0.65;

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
%4
reso = 0.01;
[I,J] = find(...
    57.67 - reso < sed_af.life & sed_af.life < 110.6 + reso &...
    11.55 - reso < sed_af.HLDfreq & sed_af.HLDfreq < 23.94 + reso ...
    );
sed_af.life(J) = sed_af.life(J)*(1/25);

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

%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------
%NMD AF CHANGES
%-------------------------------------------------------------------------- 
%-------------------------------------------------------------------------- 



%compare gamma and vc
loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )

m_nmd_modify_c05_gamma_createfigure(...
    sed_vc.freq,...
    sed_vc.life,...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),...
    sed_af.HLDfreq,...
    sed_af.life,...
    sed_per.ald.freq,...
    2*pi./sed_per.ald.freq,...
    sed_per.ald.freq,...
    1E4*(1./(sed_per.ald.freq.^4)),...
    sed_per.ald.freq,...
    1E3*(1./(sed_per.ald.freq.^2))...
    )

[nmd_vc_freq_bins nmd_vc_cond_freq] =...
    m_ald_cond_freq(...
    sed_vc.freq,...
    sed_vc.life*lj.tau,...
    sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME,20);
[ald_freq_bins ald_cond_freq] =...
    m_ald_cond_freq(...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
    sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME,20);

subplot(2,1,1),...
    loglog(...
    nmd_vc_freq_bins,nmd_vc_cond_freq,...
    ald_freq_bins,ald_cond_freq...
    )

subplot(2,1,2),...
    loglog(...
    sed_vc.freq,sed_vc.life,'.',...
    0.97*sed_per.ald.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_af.HLDfreq,sed_af.life,'.',...
    sed_per.ald.freq , 2*pi./sed_per.ald.freq...
    )

cond_nmd =...
    m_ald_cond(...
    sed_vc.life*lj.tau,...
    sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME)

cond_ald =...
    m_ald_cond(...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
    sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME)

save(strcat(str_nmd_vc,'NMDdata_modify.mat'), '-struct', 'nmd_vc');
save(strcat(str_nmd_vc,'SEDdata_modify.mat'), '-struct', 'sed_vc');

save(strcat(str_nmd_af,'NMDdata_modify.mat'), '-struct', 'nmd_af');
save(strcat(str_nmd_af,'SEDdata_modify.mat'), '-struct', 'sed_af');


%plot lifetimes and kw
NUM_BINS =
[ald(2).freq_bins ald(2).cond_freq] =...
    m_ald_cond_freq(...
    sed_per.freq/sqrt(nmd_per.vm),...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
    sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME,...
    NUM_BINS);

[sed(2).freq_bins sed(2).cond_freq] =...
    m_ald_cond_freq(...
    sed_vc.freq,...
    sed_vc.life*lj.tau,...
    sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
    nmd_per.VOLUME,...
    NUM_BINS);

%plot lifetimes
subplot(2,1,1),...
    loglog(...
    sed_per.freq,...
    1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
    sed_vc.freq,sed_vc.life,'.',...
    sed_vc.freq,2E4*sed_vc.freq.^(-4),...
    sed_vc.freq,4E2*sed_vc.freq.^(-2),...
    sed_vc.freq,2*pi./sed_vc.freq...
    )
%plot kw
subplot(2,1,2),...
    semilogx(...
    ald(2).freq_bins,ald(2).cond_freq,...
    sed(2).freq_bins,sed(2).cond_freq...
    )

