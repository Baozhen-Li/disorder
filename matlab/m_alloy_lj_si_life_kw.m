clear

constant = m_constant;

NUM_BINS = 50;



%--------------------------------------------------------------------------
%si
%--------------------------------------------------------------------------
sys_size = '8x';

ipt = 1;
str_ald = ['/home/jason/disorder2/si/ald/conv/' sys_size '/Data_fullBZ.xls'];
str_alloy = ['/home/jason/disorder2/si/alloy/0.05/' sys_size '/'];
str_nmd = ['/home/jason/disorder2/si/alloy/0.05/' sys_size '/'];
nmd=load(strcat(str_nmd,'nmd.mat'));
sed=load(strcat(str_nmd,'SEDdata.mat'));
ald = m_joe_read_data_si(str_ald);
alloy = load(strcat(str_alloy,'ALLOY.mat'));
aldsed =...
    m_joe_ald2nmd_si(...
    nmd.NUM_KPTS, nmd.kptmodelist , nmd.NUM_MODES , ald );
cond_aldsed =...
    m_ald_cond(...
    (1./( (1./(aldsed.life/sqrt(nmd.x0.vm))) +...
    (1./alloy.life(:,1)) )),...
    aldsed.vel(:,1)/sqrt(nmd.x0.vm),...
    nmd.x0.VOLUME*constant.ang2m^3)
cond_sed =...
    m_ald_cond(...
    sed.life,...
    sed.vel(:,1),...
    nmd.x0.VOLUME*constant.ang2m^3)


[ald(1).freq_bins ald(1).cond_freq] =...
    m_ald_cond_freq(...
    aldsed.freq/sqrt(nmd.x0.vm),...
    (1./( (1./(aldsed.life/sqrt(nmd.x0.vm))) +...
    (1./alloy.life(:,1)) )),...
    aldsed.vel(:,1)/sqrt(nmd.x0.vm),...
    nmd.x0.VOLUME*constant.ang2m^3,...
    NUM_BINS);

[sed(1).freq_bins sed(1).cond_freq] =...
    m_ald_cond_freq(...
    sed.freq,...
    sed.life,...
    sed.vel(:,1),...
    nmd.x0.VOLUME*constant.ang2m^3,...
    NUM_BINS);

%plot lifetimes
subplot(2,1,1),...
    loglog(...
    aldsed.freq/sqrt(nmd.x0.vm),...
    (1./( (1./(aldsed.life/sqrt(nmd.x0.vm))) +...
    (1./alloy.life(:,1)) )),'.',...
    sed.freq,sed.life,'.',...
    sed.freq,2E41*sed.freq.^(-4),...
    sed.freq,2*pi./sed.freq...
    )
%plot kw
subplot(2,1,2),...
    semilogx(...
    ald(1).freq_bins,ald(1).cond_freq,...
    sed(1).freq_bins,sed(1).cond_freq...
    )

%--------------------------------------------------------------------------
%si
%--------------------------------------------------------------------------








% 
% %--------------------------------------------------------------------------
% %lj
% %--------------------------------------------------------------------------
% str_ald = '/home/jason/disorder2/lj/ald/m1.1/10x/Data_fullBZ.xls';
% str_nmd_per = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
% str_nmd_vc = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/';
% str_nmd_af = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD_AF/1/work/';
% str_alloy = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
% 
% lj = m_lj; constant = m_constant;
% 
% ald = m_joe_read_data(str_ald);
% 
% nmd_per=load(strcat(str_nmd_per,'NMDdata.mat'));
% sed_per=load(strcat(str_nmd_per,'SEDdata.mat'));
% sed_per = nmd_convert_data(nmd_per,sed_per)
% 
% nmd_vc=load(strcat(str_nmd_vc,'NMDdata_modify.mat'));
% sed_vc=load(strcat(str_nmd_vc,'SEDdata_modify.mat'));
% sed_vc = nmd_convert_data(nmd_vc,sed_vc)
% 
% sed_per.ald = m_joe_ald2nmd( nmd_per , ald );
% alloy = load(strcat(str_alloy,'ALLOY.mat'));
% 
% 
% cond_ald =...
%     m_ald_cond(...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
%     sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME)
% 
% cond_nmd =...
%     m_ald_cond(...
%     sed_vc.life*lj.tau,...
%     sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME)
% 
% [ald(2).freq_bins ald(2).cond_freq] =...
%     m_ald_cond_freq(...
%     sed_per.freq/sqrt(nmd_per.vm),...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) )*lj.tau,...
%     sed_per.ald.vel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME,...
%     NUM_BINS);
% 
% [sed(2).freq_bins sed(2).cond_freq] =...
%     m_ald_cond_freq(...
%     sed_vc.freq,...
%     sed_vc.life*lj.tau,...
%     sed_vc.groupvel(:,1)*(lj.sigma/lj.tau),...
%     nmd_per.VOLUME,...
%     NUM_BINS);
% 
% %plot lifetimes
% subplot(2,1,1),...
%     loglog(...
%     sed_per.freq/sqrt(nmd_per.vm),...
%     1./( (1./sed_per.ald.life) + (1./alloy.life(:,1)) ),'.',...
%     sed_vc.freq,sed_vc.life,'.',...
%     sed_vc.freq,2E41*sed_vc.freq.^(-4),...
%     sed_vc.freq,2*pi./sed_vc.freq...
%     )
% %plot kw
% subplot(2,1,2),...
%     semilogx(...
%     ald(2).freq_bins,ald(2).cond_freq,...
%     sed(2).freq_bins,sed(2).cond_freq...
%     )
% 
% %--------------------------------------------------------------------------
% %lj
% %--------------------------------------------------------------------------


