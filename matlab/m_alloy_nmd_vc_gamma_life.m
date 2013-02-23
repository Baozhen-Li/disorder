%function m_ald_taud_nmd_mix(str_ald,str_nmd_per,str_nmd_vc,str_alloy)
%--------------------------------------------------------------------------
%m_ald_taud(str_ald,str_nmd_perfect,str_nmd_vc,str_alloy)
% m_ald_taud(...
% '/home/jason/disorder/lj/ald/m1.1/10x/Data_fullBZ.xls',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/',...
% '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/')
%--------------------------------------------------------------------------

clear
lj = m_lj; constant = m_constant;

%--------------------------------------------------------------------------
%0.0
%--------------------------------------------------------------------------
str_nmd = '/home/jason/disorder2/lj/alloy/10K/0.0/10x/NMD/1/work/';
nmddata = load([str_nmd 'NMDdata.mat']);
seddata = load([str_nmd 'SEDdata.mat']);
seddata = nmd_convert_data(nmddata,seddata);
prim = load([str_nmd 'SED_prim.mat']);
gamma = load([str_nmd 'SED_gamma.mat']);

%--------------------------------------------------------------------------
%0.05
%--------------------------------------------------------------------------
str_ald = '/home/jason/disorder2/lj/ald/m1.1/10x/Data_fullBZ.xls';
str_nmd_per = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
str_nmd_vc = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/';
str_nmd_af = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD_AF/1/work/';
str_alloy = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
ald(1).ald = m_joe_read_data(str_ald);
nmd(1).nmd_per=load(strcat(str_nmd_per,'NMDdata.mat'));
sed(1).sed_per=load(strcat(str_nmd_per,'SEDdata.mat'));
sed(1).sed_per = nmd_convert_data(nmd(1).nmd_per,sed(1).sed_per);
nmd(1).nmd_vc=load(strcat(str_nmd_vc,'NMDdata_new.mat'));
sed(1).sed_vc=load(strcat(str_nmd_vc,'SEDdata_new.mat'));
%sed(1).sed_vc = nmd_convert_data(nmd(1).nmd_vc,sed(1).sed_vc)
reso = 0.01;
[I,J] = find(...
    7.0 - reso < sed(1).sed_vc.life & sed(1).sed_vc.life < 8.0 + reso &...
    11.0 - reso < sed(1).sed_vc.freq & sed(1).sed_vc.freq < 12.0 + reso ...
    );
sed(1).sed_vc.life(I) = sed(1).sed_vc.life(I)*0.25;
sed(1).sed_per.ald = m_joe_ald2nmd( nmd(1).nmd_per , ald(1).ald );
alloy(1).alloy = load(strcat(str_alloy,'ALLOY.mat'));
nmd(1).nmd_af=load(strcat(str_nmd_af,'NMDdata.mat'));
sed(1).sed_af=load(strcat(str_nmd_af,'SEDdata.mat'));

%--------------------------------------------------------------------------
%0.15
%--------------------------------------------------------------------------
str_ald = '/home/jason/disorder2/lj/ald/m1.3/10x/Data_fullBZ.xls';
str_nmd_per = '/home/jason/disorder2/lj/alloy/10K/0.15/10x/nmd_vc/work/1/';
str_nmd_vc = '/home/jason/disorder2/lj/alloy/10K/0.15/10x/NMD/1/work/';
str_nmd_af = '/home/jason/disorder2/lj/alloy/10K/0.15/10x/NMD_AF/1/work/';
str_alloy = '/home/jason/disorder2/lj/alloy/10K/0.15/10x/nmd_vc/work/1/';
ald(2).ald = m_joe_read_data(str_ald);
nmd(2).nmd_per=load(strcat(str_nmd_per,'NMDdata.mat'));
sed(2).sed_per=load(strcat(str_nmd_per,'SEDdata.mat'));
sed(2).sed_per = nmd_convert_data(nmd(2).nmd_per,sed(2).sed_per);
nmd(2).nmd_vc=load(strcat(str_nmd_vc,'NMDdata.mat'));
sed(2).sed_vc=load(strcat(str_nmd_vc,'SEDdata.mat'));
%sed(2).sed_vc = nmd_convert_data(nmd(2).nmd_vc,sed(2).sed_vc)
sed(2).sed_per.ald = m_joe_ald2nmd( nmd(2).nmd_per , ald(2).ald );
alloy(2).alloy = load(strcat(str_alloy,'ALLOY.mat'));
nmd(2).nmd_af=load(strcat(str_nmd_af,'NMDdata.mat'));
sed(2).sed_af=load(strcat(str_nmd_af,'SEDdata.mat'));

%--------------------------------------------------------------------------
%0.5
%--------------------------------------------------------------------------
str_ald = '/home/jason/disorder2/lj/ald/m2/10x/Data_fullBZ.xls';
str_nmd_per = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/nmd_vc/work/1/';
str_nmd_vc = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/NMD/1/work/';
str_nmd_af = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/NMD_AF/1/work/';
str_alloy = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/nmd_vc/work/1/';
ald(3).ald = m_joe_read_data(str_ald);
nmd(3).nmd_per=load(strcat(str_nmd_per,'NMDdata.mat'));
sed(3).sed_per=load(strcat(str_nmd_per,'SEDdata.mat'));
sed(3).sed_per = nmd_convert_data(nmd(3).nmd_per,sed(3).sed_per);
nmd(3).nmd_vc=load(strcat(str_nmd_vc,'NMDdata.mat'));
sed(3).sed_vc=load(strcat(str_nmd_vc,'SEDdata.mat'));
%sed(3).sed_vc = nmd_convert_data(nmd(3).nmd_vc,sed(3).sed_vc)
sed(3).sed_per.ald = m_joe_ald2nmd( nmd(3).nmd_per , ald(3).ald );
alloy(3).alloy = load(strcat(str_alloy,'ALLOY.mat'));
nmd(3).nmd_af=load(strcat(str_nmd_af,'NMDdata.mat'));
sed(3).sed_af=load(strcat(str_nmd_af,'SEDdata.mat'));



%compare gamma and vc
subplot(4,1,1),...
loglog(...
    gamma.freq,gamma.life,'.',...
    seddata.freq,seddata.life,'.',...
    seddata.freq,10E2*seddata.freq.^(-1.9),...
    seddata.freq,(2*pi)./seddata.freq...
    )
subplot(4,1,2),...
loglog(...
    sed(1).sed_af.HLDfreq,sed(1).sed_af.life,'.',...
    sed(1).sed_vc.freq,sed(1).sed_vc.life,'.',...
    sed(1).sed_per.ald.freq,...
    5E2*(1./(sed(1).sed_per.ald.freq.^2)),...
    sed(1).sed_per.ald.freq,...
    2E4*(1./(sed(1).sed_per.ald.freq.^4)),...
    sed(1).sed_per.ald.freq ,...
    2*pi./sed(1).sed_per.ald.freq...
    )
subplot(4,1,3),...
loglog(...
    sed(2).sed_af.HLDfreq,sed(2).sed_af.life,'.',...
    sed(2).sed_vc.freq,sed(2).sed_vc.life,'.',...
    sed(2).sed_per.ald.freq,...
    5E2*(1./(sed(2).sed_per.ald.freq.^2)),...
    sed(2).sed_per.ald.freq,...
    2E4*(1./(sed(2).sed_per.ald.freq.^4)),...
    sed(2).sed_per.ald.freq ,...
    2*pi./sed(2).sed_per.ald.freq...
    )
subplot(4,1,4),...
loglog(...
    sed(3).sed_af.HLDfreq,sed(3).sed_af.life,'.',...
    sed(3).sed_vc.freq,sed(3).sed_vc.life,'.',...
    sed(3).sed_per.ald.freq,...
    5E2*(1./(sed(3).sed_per.ald.freq.^2)),...
    sed(3).sed_per.ald.freq,...
    2E4*(1./(sed(3).sed_per.ald.freq.^4)),...
    sed(3).sed_per.ald.freq ,...
    2*pi./sed(3).sed_per.ald.freq...
    )

% m_alloy_nmd_vc_gamma_life_createfigure(...
%     sed(1).sed_af.HLDfreq,sed(1).sed_af.life,...
%     sed(1).sed_vc.freq*1.025,sed(1).sed_vc.life,...
%     sed(1).sed_per.ald.freq,...
%     [...
%     2E4*(1./(sed(1).sed_per.ald.freq.^4)) ...
%     5E2*(1./(sed(1).sed_per.ald.freq.^2)) ...
%     2*pi./sed(1).sed_per.ald.freq...
%     ],...
%     sed(2).sed_af.HLDfreq,sed(2).sed_af.life,...
%     sed(2).sed_vc.freq*1.025,sed(2).sed_vc.life,...
%     sed(2).sed_per.ald.freq,...
%     [...
%     2E4*(1./(sed(2).sed_per.ald.freq.^4)) ...
%     5E2*(1./(sed(2).sed_per.ald.freq.^2)) ...
%     2*pi./sed(2).sed_per.ald.freq...
%     ],...
%     sed(3).sed_af.HLDfreq,sed(3).sed_af.life,...
%     sed(3).sed_vc.freq*1.025,sed(3).sed_vc.life,...
%     sed(3).sed_per.ald.freq,...
%     [...
%     2E4*(1./(sed(3).sed_per.ald.freq.^4)) ...
%     5E2*(1./(sed(3).sed_per.ald.freq.^2)) ...
%     2*pi./sed(3).sed_per.ald.freq...
%     ]...
%     )

% m_alloy_nmd_gamma_life_createfigure(...
%     X1, Y1,...
%     X2, Y2,...
%     X3, YMatrix1,...
%     X4, Y3,...
%     X5, Y4,...
%     X6, YMatrix2,...
%     X7, Y5,...
%     X8, Y6,...
%     X9, YMatrix3...
%     )


% %compare ald and vc
% subplot(3,1,1),...
% loglog(...
%     sed(1).sed_vc.freq,sed(1).sed_vc.life,'.',...
%     0.97*sed(1).sed_per.ald.freq,...
%     1./( (1./sed(1).sed_per.ald.life) +...
%     (1./alloy(1).alloy.life(:,1)) ),'.',...
%     sed(1).sed_per.ald.freq,...
%     2E4*(1./(sed(1).sed_per.ald.freq.^4)),...
%     sed(1).sed_per.ald.freq,...
%     5E2*(1./(sed(1).sed_per.ald.freq.^2)),...
%     sed(1).sed_per.ald.freq ,...
%     2*pi./sed(1).sed_per.ald.freq...
%     )
% subplot(3,1,2),...
% loglog(...
%     sed(2).sed_vc.freq,sed(2).sed_vc.life,'.',...
%     0.97*sed(2).sed_per.ald.freq,...
%     1./( (1./sed(2).sed_per.ald.life) +...
%     (1./alloy(2).alloy.life(:,1)) ),'.',...
%     sed(2).sed_per.ald.freq,...
%     2E4*(1./(sed(2).sed_per.ald.freq.^4)),...
%     sed(2).sed_per.ald.freq,...
%     5E2*(1./(sed(2).sed_per.ald.freq.^2)),...
%     sed(2).sed_per.ald.freq ,...
%     2*pi./sed(2).sed_per.ald.freq...
%     )
% subplot(3,1,3),...
% loglog(...
%     sed(3).sed_vc.freq,sed(3).sed_vc.life,'.',...
%     0.97*sed(3).sed_per.ald.freq,...
%     1./( (1./sed(3).sed_per.ald.life) +...
%     (1./alloy(3).alloy.life(:,1)) ),'.',...
%     sed(3).sed_per.ald.freq,...
%     2E4*(1./(sed(3).sed_per.ald.freq.^4)),...
%     sed(3).sed_per.ald.freq,...
%     5E2*(1./(sed(3).sed_per.ald.freq.^2)),...
%     sed(3).sed_per.ald.freq ,...
%     2*pi./sed(3).sed_per.ald.freq...
%     )



% m_nmd_modify_c05_gamma_createfigure(...
%     sed_vc.freq,...
%     sed_vc.life,...
%     0.97*sed_per.ald.freq,...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),...
%     sed_af.HLDfreq,...
%     sed_af.life,...
%     sed_per.ald.freq,...
%     2*pi./sed_per.ald.freq,...
%     sed_per.ald.freq,...
%     1E4*(1./(sed_per.ald.freq.^4)),...
%     sed_per.ald.freq,...
%     1E3*(1./(sed_per.ald.freq.^2))...
%     )

% [nmd_vc_freq_bins nmd_vc_cond_freq] =...
%     m_ald_cond_freq(...
%     sed_vc.freq,...
%     sed_vc.life*lj.tau,...
%     sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME,20);
% [ald_freq_bins ald_cond_freq] =...
%     m_ald_cond_freq(...
%     0.97*sed_per.ald.freq,...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
%     sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME,20);
% 
% subplot(2,1,1),...
%     loglog(...
%     nmd_vc_freq_bins,nmd_vc_cond_freq,...
%     ald_freq_bins,ald_cond_freq...
%     )
% 
% subplot(2,1,2),...
%     loglog(...
%     sed_vc.freq,sed_vc.life,'.',...
%     0.97*sed_per.ald.freq,...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
%     sed_af.HLDfreq,sed_af.life,'.',...
%     sed_per.ald.freq , 2*pi./sed_per.ald.freq...
%     )
% 
% cond_nmd =...
%     m_ald_cond(...
%     sed_vc.life*lj.tau,...
%     sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME)
% 
% cond_ald =...
%     m_ald_cond(...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
%     sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME)


%end









% reso = 0.01;
% [I,J] = find(...
%     7.0 - reso < sed_vc.life & sed_vc.life < 8.0 + reso &...
%     11.0 - reso < sed_vc.freq & sed_vc.freq < 12.0 + reso ...
%     );
% sed_vc.life(I) = sed_vc.life(I)*0.25;
% loglog(...
%     sed_vc.freq,sed_vc.life,'.')
% save(strcat(str_nmd_vc,'NMDdata_new.mat'), '-struct', 'nmd_vc');
% save(strcat(str_nmd_vc,'SEDdata_new.mat'), '-struct', 'sed_vc');


