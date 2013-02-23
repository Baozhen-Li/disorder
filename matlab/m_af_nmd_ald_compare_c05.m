clear

VIRTUAL_MASS = 1.1;
lj = m_lj;
%--------------------------------------------------------------------------
%c=0.0
%--------------------------------------------------------------------------
ipt = 1;
%af
str.af = '/home/jason/disorder2/lj/alloy/10K/0.0/10x/work/';
af(ipt).af=m_af_load(str.af);
%vcnmd
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.0/10x/NMD/1/work/';
vcnmd(ipt).nmd = load([str.nmd 'NMDdata.mat']);
vcnmd(ipt).sed = load([str.nmd 'SEDdata.mat']);
vcnmd(ipt).sed = nmd_convert_data(vcnmd(ipt).nmd,vcnmd(ipt).sed);
%gnmd
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.0/10x/NMD_AF/1/work/';
% gnmd(ipt).nmd = load([str.nmd 'NMDdata.mat']);
% gnmd(ipt).sed = load([str.nmd 'SEDavg.mat']);
%vcald
str.alloy = '/home/jason/disorder2/lj/alloy/10K/0.0/10x/NMD/1/work/';
% alloy(ipt).alloy = load([str.alloy 'ALLOY.mat']);
str.ald = '/home/jason/disorder2/lj/ald/m1/10x/Data_fullBZ.xls';
vcald(ipt).ald = m_joe_read_data([str.ald]);
vcald(ipt).sedald = m_joe_ald2nmd( vcnmd(ipt).nmd , vcald(ipt).ald );

loglog(...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life.*vcnmd(ipt).sed.groupvel(:,1),'.',...
    vcald(ipt).ald.freq*0.97,...
    vcald(ipt).ald.life.*vcald(ipt).ald.vel(:,1),'.',...
    af(ipt).af.freq,af(ipt).af.Di(:,2),'.'...
    )
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%c=0.05
%--------------------------------------------------------------------------
ipt = 2;
%af
str.af = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/work/';
af(ipt).af=m_af_load(str.af);
%vcnmd
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/';
vcnmd(ipt).nmd = load([str.nmd 'NMDdata_modify.mat']);
vcnmd(ipt).sed = load([str.nmd 'SEDdata_modify.mat']);
% vcnmd(ipt).sed = nmd_convert_data(vcnmd(ipt).nmd,vcnmd(ipt).sed);
%gnmd
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD_AF/1/work/';
gnmd(ipt).nmd = load([str.nmd 'NMDdata.mat']);
gnmd(ipt).sed = load([str.nmd 'SEDdata.mat']);
%vcald
str.alloy = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/';
alloy(ipt).alloy = load([str.alloy 'ALLOY.mat']);
str.ald = '/home/jason/disorder2/lj/ald/m1.1/10x/Data_fullBZ.xls';
vcald(ipt).ald = m_joe_read_data([str.ald]);
vcald(ipt).sedald = m_joe_ald2nmd( vcnmd(ipt).nmd , vcald(ipt).ald );

vcnmd(ipt).sound =...
    ( (2/3)*(520) + (1/3)*(970) )*sqrt(3)...
    *vcnmd(1).nmd.LJ.tau/vcnmd(1).nmd.LJ.sigma;

af(ipt).cond =...
    m_af_cond(...
    af(ipt).af.freq,...
    af(ipt).af.Di(:,2)*vcnmd(ipt).nmd.LJ.sigma^2/vcnmd(ipt).nmd.LJ.tau,...
    af(ipt).af.VOLUME*vcnmd(ipt).nmd.LJ.sigma^3);

vcnmd(ipt).cond =...
    m_ald_cond(...
    vcnmd(ipt).sed.life*vcnmd(ipt).nmd.LJ.tau,...
    vcnmd(ipt).sed.groupvel(:,1)*vcnmd(ipt).nmd.LJ.sigma/vcnmd(ipt).nmd.LJ.tau,...
    vcnmd(ipt).nmd.VOLUME);

af(ipt).cond_scaled =...
    m_af_cond(...
    af(ipt).af.freq,...
    af(ipt).af.Di(:,2)*vcnmd(ipt).nmd.LJ.sigma^2/vcnmd(ipt).nmd.LJ.tau*...
    (vcnmd(ipt).cond / af(ipt).cond),...
    af(ipt).af.VOLUME*vcnmd(ipt).nmd.LJ.sigma^3);


loglog(...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life,'.',...
    alloy(ipt).alloy.freq'*0.97,...
    alloy(ipt).alloy.life(:,1),'.',...
    vcald(ipt).sedald.freq*0.97,...
    vcald(ipt).sedald.life,'.'...
    )

loglog(...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life,'.',...
    vcald(ipt).sedald.freq*0.97,...
    1./(1./alloy(ipt).alloy.life(:,1) +...
    1./vcald(ipt).sedald.life),'.'...
    )



NUM_BINS = 20;
[af(ipt).freq_bins af(ipt).cond_freq] =...
    m_af_cond_freq(...
    af(ipt).af.freq,...
    af(ipt).af.Di(:,2)*vcnmd(ipt).nmd.LJ.sigma^2/vcnmd(ipt).nmd.LJ.tau*...
    (vcnmd(ipt).cond / af(ipt).cond),...
    af(ipt).af.VOLUME*vcnmd(ipt).nmd.LJ.sigma^3,NUM_BINS);
[vcnmd(1).freq_bins vcnmd(1).cond_freq] =...
    m_ald_cond_freq(...
    vcnmd(1).sed.freq,...
    vcnmd(1).sed.life*vcnmd(1).nmd.LJ.tau,...
    vcnmd(1).sed.groupvel(:,1)*vcnmd(1).nmd.LJ.sigma/vcnmd(1).nmd.LJ.tau,...
    vcnmd(1).nmd.VOLUME,NUM_BINS)
[vcnmd(ipt).freq_bins vcnmd(ipt).cond_freq] =...
    m_ald_cond_freq(...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life*vcnmd(ipt).nmd.LJ.tau,...
    vcnmd(ipt).sed.groupvel(:,1)*vcnmd(ipt).nmd.LJ.sigma/vcnmd(ipt).nmd.LJ.tau,...
    vcnmd(1).nmd.VOLUME,NUM_BINS)
[vcald(1).freq_bins vcald(1).cond_freq] =...
    m_ald_cond_freq(...
    vcald(1).sedald.freq,...
    vcald(1).sedald.life*vcnmd(1).nmd.LJ.tau,...
    vcald(1).sedald.vel(:,1)*vcnmd(1).nmd.LJ.sigma/vcnmd(1).nmd.LJ.tau,...
    vcnmd(1).nmd.VOLUME,...
    NUM_BINS)
[vcald(ipt).freq_bins vcald(ipt).cond_freq] =...
    m_ald_cond_freq(...
    vcald(ipt).sedald.freq,...
    1./(1./alloy(ipt).alloy.life(:,1) +...
    1./vcald(ipt).sedald.life)*vcnmd(ipt).nmd.LJ.tau,...
    vcald(ipt).sedald.vel(:,1)*vcnmd(ipt).nmd.LJ.sigma/vcnmd(ipt).nmd.LJ.tau,...
    vcnmd(1).nmd.VOLUME,...
    NUM_BINS)


loglog(...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life,'.',...
    alloy(ipt).alloy.freq'*0.97,...
    alloy(ipt).alloy.life(:,1),'.',...
    vcald(ipt).sedald.freq*0.97,...
    vcald(ipt).sedald.life,'.'...
    )

loglog(...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life,'.',...
    vcald(ipt).sedald.freq*0.97,...
    1./(1./alloy(ipt).alloy.life(:,1) +...
    1./vcald(ipt).sedald.life),'.'...
    )
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------



%--------------------------------------------------------------------------
%amor
%--------------------------------------------------------------------------
%af
ipt=5;
str.af = '/home/jason/disorder2/lj/amor/10x/work/';
af(ipt).af=m_af_load(str.af);

af(ipt).cond =...
    m_af_cond(...
    af(ipt).af.freq,...
    af(ipt).af.Di(:,2)*vcnmd(1).nmd.LJ.sigma^2/vcnmd(1).nmd.LJ.tau...
    /sqrt(VIRTUAL_MASS),...
    af(ipt).af.VOLUME*vcnmd(1).nmd.LJ.sigma^3);
NUM_BINS = 40;
[af(ipt).freq_bins af(ipt).cond_freq] =...
    m_af_cond_freq(...
    af(ipt).af.freq,...
    af(ipt).af.Di(:,2)*vcnmd(1).nmd.LJ.sigma^2/vcnmd(1).nmd.LJ.tau...
    /sqrt(VIRTUAL_MASS),...
    af(ipt).af.VOLUME*vcnmd(1).nmd.LJ.sigma^3,NUM_BINS);
af(ipt).sound =...
    ( (2/3)*(623.27) + (1/3)*(1412.11) )...
    *vcnmd(1).nmd.LJ.tau/vcnmd(1).nmd.LJ.sigma...
    /sqrt(VIRTUAL_MASS);

ipt=2;
[Iald Jald] =...
    find(...
    vcald(ipt).sedald.freq*0.97 < 5.801 &...
    1./(1./alloy(ipt).alloy.life(:,1) +...
    1./vcald(ipt).sedald.life).*vcald(1).sedald.vel(:,1).^2 < 0.1 );
vcald(1).sedald.vel(Iald,1) = 0;
1./(1./alloy(ipt).alloy.life(Iald,1) +...
    1./vcald(ipt).sedald.life(Iald))





%nmd,ald alloy vs amor
subplot(3,1,1),...
loglog(...
    vcnmd(1).sed.freq,...
    vcnmd(1).sed.life,'.',...
    vcald(ipt).sedald.freq*1.01,...
    vcald(ipt).sedald.life,'.',...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life,'.',...
    vcald(ipt).sedald.freq*0.9675,...
    1./(1./alloy(ipt).alloy.life(:,1) + 1./vcald(ipt).sedald.life),'.',...
    vcnmd(ipt).sed.freq,2E4*1./(vcnmd(ipt).sed.freq.^(4)),...
    vcnmd(ipt).sed.freq,5E2*1./(vcnmd(ipt).sed.freq.^(2)),...
    vcnmd(ipt).sed.freq,2*pi./(vcnmd(ipt).sed.freq.^(1))...
    )
subplot(3,1,2),...
loglog(...
    vcnmd(1).sed.freq,...
    vcnmd(1).sed.life.*vcnmd(1).sed.groupvel(:,1).^2,'.',...
    vcald(ipt).sedald.freq*1.01,...
    vcald(1).sedald.life.*vcald(ipt).sedald.vel(:,1).^2,'.',...
    vcnmd(ipt).sed.freq,...
    vcnmd(ipt).sed.life.*vcnmd(ipt).sed.groupvel(:,1).^2,'.',...
    vcald(ipt).sedald.freq*0.97,...
    1./(1./alloy(ipt).alloy.life(:,1) +...
    1./vcald(ipt).sedald.life).*vcald(1).sedald.vel(:,1).^2,'.',...
    vcnmd(ipt).sed.freq/sqrt(VIRTUAL_MASS),...
    ones(length(vcnmd(ipt).sed.freq),1)*...
    vcnmd(1).nmd.alat/2*lj.sound/0.75*(1/3)...
    )
subplot(3,1,3),...
    semilogx(...
    vcnmd(1).freq_bins,vcnmd(1).cond_freq,...
    vcald(1).freq_bins,vcald(1).cond_freq,...
    vcnmd(ipt).freq_bins,vcnmd(ipt).cond_freq,...
    vcald(ipt).freq_bins,vcald(ipt).cond_freq...
    )


%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------


% subplot(2,1,1),...
% loglog(...
%     af(5).af.freq/sqrt(1.1),af(5).af.Di(:,2)/sqrt(VIRTUAL_MASS),'.',...
%     vcnmd(ipt).sed.freq,...
%     vcnmd(ipt).sed.life.*vcnmd(ipt).sed.groupvel(:,1).^2,'.',...
%     vcald(ipt).sedald.freq*0.97,...
%     1./(1./alloy(ipt).alloy.life(:,1) +...
%     1./vcald(ipt).sedald.life).*vcald(1).sedald.vel(:,1).^2,'.',...
%     vcald(ipt).sedald.freq*0.97,...
%     ones(length(vcald(ipt).sedald.freq),1)*...
%     vcnmd(1).nmd.alat*af(5).sound*(1/3)...
%     )
% subplot(2,1,2),...
%     semilogx(...
%     af(5).freq_bins,af(5).cond_freq,...
%     vcnmd(ipt).freq_bins,vcnmd(ipt).cond_freq,...
%     vcald(ipt).freq_bins,vcald(ipt).cond_freq...
%     )





