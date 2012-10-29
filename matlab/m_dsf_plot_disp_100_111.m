clear
hold on
%--------------------------------------------------------------------------
%110 c=0.05
%--------------------------------------------------------------------------
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
sed = load(strcat(str.nmd,'SEDdata.mat'));
nmd = load(strcat(str.nmd,'NMDdata.mat'));
sed = nmd_convert_data(nmd,sed);
str.dsf = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/work/';
dsf.long = load(strcat(str.dsf,'DSF_long_111.mat'));
dsf.tran = load(strcat(str.dsf,'DSF_tran_111.mat'));


for ikpt=1:size(dsf.long.kpt,1)
    I = find(...
            dsf.long.kpt(ikpt,1)*nmd.Nx==sed.kpt(:,1) &...
            dsf.long.kpt(ikpt,2)*nmd.Nx==sed.kpt(:,2) &...
            dsf.long.kpt(ikpt,3)*nmd.Nx==sed.kpt(:,3)...
        );
    dsf.sed.kpt(ikpt,:) = sed.kpt(I(1),:);
    dsf.sed.freq(ikpt,:) = sed.freq(I)';
    dsf.sed.sedfreq(ikpt,:) = sed.sedfreq(I)';
    sed.kpt(I(1),:)
    sed.freq(I)'
    sed.kpt(I(1),:)
    dsf.long.kpt(ikpt,:)
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------     
end

subplot(3,3,1),...
    semilogx(...
    dsf.long.SL(2000:4000,1),dsf.long.freq_range(2000:4000),'.',...
    dsf.long.SL(5000:8000,2),dsf.long.freq_range(5000:8000),'.',...
    dsf.long.SL(7000:10000,3),dsf.long.freq_range(7000:10000),'.',...
    dsf.long.SL(9000:11000,4),dsf.long.freq_range(9000:11000),'.',...
    dsf.long.SL(10000:12000,5),dsf.long.freq_range(10000:12000),'.'...
    )
subplot(3,3,2),...
    plot(...
    [0;dsf.long.kpt(:,1)]*nmd.Nx,...
    [0;dsf.sed.freq(1,1);dsf.sed.freq(2,1);dsf.sed.freq(3,1);...
    dsf.sed.freq(4,1);dsf.sed.freq(5,1)],'.',...
    [0;dsf.long.kpt(:,1)]*nmd.Nx,...
    [0;dsf.sed.freq(1,3);dsf.sed.freq(2,3);dsf.sed.freq(3,9);...
    dsf.sed.freq(4,9);dsf.sed.freq(5,9)]*1.025,'.'...
    )
subplot(3,3,3),...
    semilogx(...
    dsf.tran.SL(:,1),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,2),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,3),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,4),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,5),dsf.tran.freq_range,'.'...
    )
set(gca,'XDir','reverse');
%--------------------------------------------------------------------------
%111 c=0.05
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%100 c=0.05
%--------------------------------------------------------------------------
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/nmd_vc/work/1/';
sed = load(strcat(str.nmd,'SEDdata.mat'));
nmd = load(strcat(str.nmd,'NMDdata.mat'));
sed = nmd_convert_data(nmd,sed);
str.dsf = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/work/';
dsf.long = load(strcat(str.dsf,'DSF_long_100.mat'));
dsf.tran = load(strcat(str.dsf,'DSF_tran_100.mat'));

for ikpt=1:size(dsf.long.kpt,1)
    I = find(...
            dsf.long.kpt(ikpt,1)*nmd.Nx==sed.kpt(:,1) &...
            dsf.long.kpt(ikpt,2)*nmd.Nx==sed.kpt(:,2) &...
            dsf.long.kpt(ikpt,3)*nmd.Nx==sed.kpt(:,3)...
        );
    dsf.sed.kpt(ikpt,:) = sed.kpt(I(1),:);
    dsf.sed.freq(ikpt,:) = sed.freq(I)';
    dsf.sed.sedfreq(ikpt,:) = sed.sedfreq(I)';
    sed.kpt(I(1),:)
    sed.freq(I)'
    sed.kpt(I(1),:)
    dsf.long.kpt(ikpt,:)
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------     
end

subplot(3,3,4),...
    semilogx(...
    dsf.long.SL(100:11000,1),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,2),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,3),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,4),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,5),dsf.long.freq_range(100:11000),'.'...
    )
subplot(3,3,5),...
    plot(...
    [0;dsf.long.kpt(:,1)]*nmd.Nx,...
    [0;dsf.sed.freq(1,1);dsf.sed.freq(2,1);dsf.sed.freq(3,1);...
    dsf.sed.freq(4,1);dsf.sed.freq(5,1)],'.',...
    [0;dsf.long.kpt(:,1)]*nmd.Nx,...
    [0;dsf.sed.freq(1,3);dsf.sed.freq(2,3);dsf.sed.freq(3,3);...
    dsf.sed.freq(4,5);dsf.sed.freq(5,5)]*1.025,'.'...
    )
subplot(3,3,6),...
    semilogx(...
    dsf.tran.SL(:,1),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,2),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,3),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,4),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,5),dsf.tran.freq_range,'.'...
    )
set(gca,'XDir','reverse');
%--------------------------------------------------------------------------
%100 c=0.05
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%100 c=0.5
%--------------------------------------------------------------------------
str.nmd = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/nmd_vc/work/1/';
sed = load(strcat(str.nmd,'SEDdata.mat'));
nmd = load(strcat(str.nmd,'NMDdata.mat'));
sed = nmd_convert_data(nmd,sed);
str.dsf = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/work/';
dsf.long = load(strcat(str.dsf,'DSF_long_100.mat'));
dsf.tran = load(strcat(str.dsf,'DSF_tran_100.mat'));

for ikpt=1:size(dsf.long.kpt,1)
    I = find(...
            dsf.long.kpt(ikpt,1)*nmd.Nx==sed.kpt(:,1) &...
            dsf.long.kpt(ikpt,2)*nmd.Nx==sed.kpt(:,2) &...
            dsf.long.kpt(ikpt,3)*nmd.Nx==sed.kpt(:,3)...
        );
    dsf.sed.kpt(ikpt,:) = sed.kpt(I(1),:);
    dsf.sed.freq(ikpt,:) = sed.freq(I)';
    dsf.sed.sedfreq(ikpt,:) = sed.sedfreq(I)';
    sed.kpt(I(1),:)
    sed.freq(I)'
    sed.kpt(I(1),:)
    dsf.long.kpt(ikpt,:)
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------     
end

subplot(3,3,7),...
    semilogx(...
    dsf.long.SL(100:11000,1),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,2),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,3),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,4),dsf.long.freq_range(100:11000),'.',...
    dsf.long.SL(100:11000,5),dsf.long.freq_range(100:11000),'.'...
    )
subplot(3,3,8),...
    plot(...
    [0;dsf.long.kpt(:,1)]*nmd.Nx,...
    [0;dsf.sed.freq(1,1);dsf.sed.freq(2,1);dsf.sed.freq(3,1);...
    dsf.sed.freq(4,1);dsf.sed.freq(5,1)],'.',...
    [0;dsf.long.kpt(:,1)]*nmd.Nx,...
    [0;dsf.sed.freq(1,3);dsf.sed.freq(2,3);dsf.sed.freq(3,3);...
    dsf.sed.freq(4,5);dsf.sed.freq(5,5)]*1.025,'.'...
    )
subplot(3,3,9),...
    semilogx(...
    dsf.tran.SL(:,1),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,2),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,3),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,4),dsf.tran.freq_range,'.',...
    dsf.tran.SL(:,5),dsf.tran.freq_range,'.'...
    )
set(gca,'XDir','reverse');
%--------------------------------------------------------------------------
%100 c=0.5
%--------------------------------------------------------------------------


% m_dsf_plot_disp_100_111_createfigure(...
%     X1, Y1,...
%     X2, X3,...
%     X4, X5,...
%     X6, YMatrix1,...
%     X7, X8,...
%     X9, X10,...
%     X11, Y2,...
%     X12, X13,...
%     X14, X15,...
%     X16, YMatrix2,...
%     X17, Y3,...
%     X18,...
%     Y4, X19,...
%     Y5, X20,...
%     Y6, X21,...
%     Y7, YMatrix3,...
%     X22, Y8,...
%     X23, X24,...
%     X25, X26,...
%     YMatrix4, X27,...
%     Y9, X28,...
%     X29, X30,...
%     X31...
%     )

