clear
lj = m_lj; constant = m_constant;
str_af = '/home/jason/disorder2/lj/amor/8x/work/';

%.eigvec = load(strcat(str_af,'AF_eigvec_1.dat'));
AF.freq = load(strcat(str_af,'AF_freq_1.dat'));
AF.x0 = m_x0_read([str_af 'x0.data']);


DSF(1).long = load([str_af 'DSF_long_avg_b40_avg10.mat']);
DSF(1).tran = load([str_af 'DSF_tran_avg_b40_avg10.mat']);

semilogy(...
    DSF(1).long.freq_range,DSF(1).long.SL(:,1),'.',...
    DSF(1).long.freq_range,DSF(1).long.SL(:,2),'.',...
    DSF(1).long.freq_range,DSF(1).long.SL(:,3),'.',...
    DSF(1).long.freq_range,DSF(1).long.SL(:,4),'.',...
    DSF(1).long.freq_range,DSF(1).long.SL(:,5),'.',...
    DSF(1).long.freq_range,DSF(1).long.SL(:,6),'.',...
    DSF(1).long.freq_range,DSF(1).long.SL(:,7),'.'...
    )
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------
semilogy(...
    DSF(1).tran.freq_range,DSF(1).tran.SL(:,1),'.',...
    DSF(1).tran.freq_range,DSF(1).tran.SL(:,2),'.',...
    DSF(1).tran.freq_range,DSF(1).tran.SL(:,3),'.',...
    DSF(1).tran.freq_range,DSF(1).tran.SL(:,4),'.',...
    DSF(1).tran.freq_range,DSF(1).tran.SL(:,5),'.',...
    DSF(1).tran.freq_range,DSF(1).tran.SL(:,6),'.',...
    DSF(1).tran.freq_range,DSF(1).tran.SL(:,7),'.'...
    )
%--------------------------------------------------------------------------
pause
%--------------------------------------------------------------------------


% %6x
% DSF(1).tran.kpt([1 2 3 4 5 6 7],1);
% DSF(1).tran.disp.freq =...
%     [6.773E12 6.880E12 6.933E12 6.906E12 6.906E12 6.960E12 7.094E12 ];
% plot(...
%     [0;DSF(1).tran.kpt([1 2 3 4 5 6 7],1)],...
%     [0 DSF(1).tran.disp.freq]...
%     )








































% DSF_FIT(1).DSF_FIT =...
%     load(strcat(str_af,'DSF_FIT_b2.mat'));
% DSF_FIT(2).DSF_FIT =...
%     load(strcat(str_af,'DSF_FIT_b5.mat'));
% DSF_FIT(3).DSF_FIT =...
%     load(strcat(str_af,'DSF_FIT_b10.mat'));
% DSF_FIT(4).DSF_FIT =...
%     load(strcat(str_af,'DSF_FIT_b20.mat'));


% 
% [sed.dosx sed.dosy] = m_dos(sed.freq,20);
% [AF.dosx AF.dosy] = m_dos(AF.freq,20);
% %find avg level spacings
% AF.freq_sorted = sort(AF.freq);
% AF.dwij =...
%     AF.freq_sorted(2:length(AF.freq_sorted))...
%     -...
%     AF.freq_sorted(1:length(AF.freq_sorted)-1);
% AF.dw_avg =...
%     real(...
%     mean(...
%     AF.freq_sorted(2:length(AF.freq_sorted))...
%     -...
%     AF.freq_sorted(1:length(AF.freq_sorted)-1)));
% 
% %end correction
% reso1 = 0.1; reso2 = 0.1;
% [I,J] = find(...
%     4.5 - reso1 < DSF_FIT(1).DSF_FIT.life & ...
%     DSF_FIT(1).DSF_FIT.life < 70 + reso1 &...
%     15.0 - reso2 < DSF_FIT(1).DSF_FIT.freq & ...
%     DSF_FIT(1).DSF_FIT.freq < 26.0 + reso2 ...
%     );
% DSF_FIT(1).DSF_FIT.life(J) = 1.5*5.24; 
% %end correction
% reso1 = 0.1; reso2 = 0.1;
% [I,J] = find(...
%     4.5 - reso1 < DSF_FIT(2).DSF_FIT.life & ...
%     DSF_FIT(2).DSF_FIT.life < 70 + reso1 &...
%     15.0 - reso2 < DSF_FIT(2).DSF_FIT.freq & ...
%     DSF_FIT(2).DSF_FIT.freq < 26.0 + reso2 ...
%     );
% DSF_FIT(2).DSF_FIT.life(J) = 1.5*4.234; 
% %end correction
% reso1 = 0.1; reso2 = 0.1;
% [I,J] = find(...
%     4.5 - reso1 < DSF_FIT(3).DSF_FIT.life & ...
%     DSF_FIT(3).DSF_FIT.life < 70 + reso1 &...
%     15.0 - reso2 < DSF_FIT(3).DSF_FIT.freq & ...
%     DSF_FIT(3).DSF_FIT.freq < 26.0 + reso2 ...
%     );
% DSF_FIT(3).DSF_FIT.life(J) = 1.5*3.943; 
% %end correction
% reso1 = 0.1; reso2 = 0.1;
% [I,J] = find(...
%     4.5 - reso1 < DSF_FIT(4).DSF_FIT.life & ...
%     DSF_FIT(4).DSF_FIT.life < 70 + reso1 &...
%     15.0 - reso2 < DSF_FIT(4).DSF_FIT.freq & ...
%     DSF_FIT(4).DSF_FIT.freq < 26.0 + reso2 ...
%     );
% DSF_FIT(4).DSF_FIT.life(J) = 1.5*3.764; 
% 
% % loglog(...
% %     sed.freq,sed.life,'.',...
% %     DSF_FIT(1).DSF_FIT.freq_sed, DSF_FIT(1).DSF_FIT.life_sed,'.',...
% %     DSF_FIT(1).DSF_FIT.freq, DSF_FIT(1).DSF_FIT.life,'.',...
% %     DSF_FIT(2).DSF_FIT.freq, DSF_FIT(2).DSF_FIT.life,'.',...
% %     DSF_FIT(3).DSF_FIT.freq, DSF_FIT(3).DSF_FIT.life,'.',...
% %     DSF_FIT(4).DSF_FIT.freq, DSF_FIT(4).DSF_FIT.life,'.',...
% %     DSF_FIT(1).DSF_FIT.freq,2*pi./DSF_FIT(1).DSF_FIT.freq,...
% %     DSF_FIT(1).DSF_FIT.freq,(1E4)*1./(DSF_FIT(1).DSF_FIT.freq.^4),...
% %     DSF_FIT(1).DSF_FIT.freq,(1E3)*1./(DSF_FIT(1).DSF_FIT.freq.^2)...
% %     )
% 
% subplot(3,1,1),...
% loglog(...
%     sed.freq,sed.life,'.',...
%     DSF_FIT(1).DSF_FIT.freq, DSF_FIT(1).DSF_FIT.life,'.',...
%     DSF_FIT(2).DSF_FIT.freq, DSF_FIT(2).DSF_FIT.life,'.',...
%     DSF_FIT(3).DSF_FIT.freq, DSF_FIT(3).DSF_FIT.life,'.',...
%     DSF_FIT(4).DSF_FIT.freq, DSF_FIT(4).DSF_FIT.life,'.',...
%     DSF_FIT(1).DSF_FIT.freq,2*pi./DSF_FIT(1).DSF_FIT.freq,...
%     DSF_FIT(1).DSF_FIT.freq,(1E4)*1./(DSF_FIT(1).DSF_FIT.freq.^4),...
%     DSF_FIT(1).DSF_FIT.freq,(1E3)*1./(DSF_FIT(1).DSF_FIT.freq.^2)...
%     )
% subplot(3,1,2),...
%     semilogx(...
%     sed.dosx,sed.dosy,...
%     AF.dosx,AF.dosy...
%     )
% subplot(3,1,3),...
%     loglog(...
%     AF.freq_sorted(2:length(AF.freq_sorted)),AF.dwij,'.',...
%     AF.freq_sorted(2:length(AF.freq_sorted)),...
%     ones(length(AF.freq_sorted)-1,1)*AF.dw_avg...
%     )

% m_dsf_fit_plot_createfigure(...
%     sed.freq,sed.life,...
%     DSF_FIT(1).DSF_FIT.freq,...
%     [...
%     DSF_FIT(1).DSF_FIT.life DSF_FIT(2).DSF_FIT.life 
%     DSF_FIT(3).DSF_FIT.life DSF_FIT(4).DSF_FIT.life...
%     ]
%     DSF_FIT(1).DSF_FIT.freq,...
%     2*pi./DSF_FIT(1).DSF_FIT.freq (1E4)*1./(DSF_FIT(1).DSF_FIT.freq.^4) 
%     (1E3)*1./(DSF_FIT(1).DSF_FIT.freq.^2)...
%     ],...
%     sed.dosx,sed.dosy,...
%     AF.dosx,AF.dosy,...
%     AF.freq_sorted(2:length(AF.freq_sorted)),AF.dwij,...
%     sed.dosx,sed.dosy,...
%     AF.dosx,AF.dosy,...
%     AF.freq_sorted(2:length(AF.freq_sorted)),...
%     [...
%     AF.dwij ones(length(AF.freq_sorted)-1,1)*AF.dw_avg...
%     ]...
%     )
% 
% m_dsf_fit_plot_createfigure(...
%     X1, Y1,...
%     X2, YMatrix1,...
%     X3, Y2,...
%     X4, Y3,...
%     X5, Y4,...
%     X6, Y5,...
%     X7, Y6,...
%     X8, YMatrix2)


