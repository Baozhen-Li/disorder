clear

constant = m_constant; lj = m_lj;

%--------------------------------------------------------------------------
%AF load
str.AF = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/work/';
af(1).af = m_af_load( str.AF );
%NMD load
str.NMD = '/home/jason/disorder2/lj/alloy/10K/0.05/10x/NMD/1/work/';
NMD(1).NMD=load(strcat(str.NMD,'NMDdata.mat'));
SED(1).SED=load(strcat(str.NMD,'SEDdata.mat'));
%convert freq to cols
SED(1).SED = nmd_convert_data(NMD(1).NMD,SED(1).SED);
NUM_BIN = 14;
[af(1).af.DOSX af(1).af.DOSY] =...
    m_dos( af(1).af.freq, NUM_BIN , 100 );
NUM_BIN = 14;
[SED(1).SED.DOSX SED(1).SED.DOSY] =...
    m_dos( SED(1).SED.freq , NUM_BIN , 1000 );
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%AF load
str.AF = '/home/jason/disorder2/lj/alloy/10K/0.15/10x/work/';
af(2).af = m_af_load( str.AF );
%NMD load
str.NMD = '/home/jason/disorder2/lj/alloy/10K/0.15/10x/NMD/1/work/';
NMD(2).NMD=load(strcat(str.NMD,'NMDdata.mat'));
SED(2).SED=load(strcat(str.NMD,'SEDdata.mat'));
%convert freq to cols
SED(2).SED = nmd_convert_data(NMD(2).NMD,SED(2).SED);
NUM_BIN = 14;
[af(2).af.DOSX af(2).af.DOSY] =...
    m_dos( af(2).af.freq, NUM_BIN , 100 );
NUM_BIN = 14;
[SED(2).SED.DOSX SED(2).SED.DOSY] =...
    m_dos( SED(2).SED.freq , NUM_BIN , 1000 );
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
%AF load
str.AF = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/work/';
af(3).af = m_af_load( str.AF );
%NMD load
str.NMD = '/home/jason/disorder2/lj/alloy/10K/0.5/10x/NMD/1/work/';
NMD(3).NMD=load(strcat(str.NMD,'NMDdata.mat'));
SED(3).SED=load(strcat(str.NMD,'SEDdata.mat'));
%convert freq to cols
SED(3).SED = nmd_convert_data(NMD(3).NMD,SED(3).SED);
NUM_BIN = 16;
[af(3).af.DOSX af(3).af.DOSY] =...
    m_dos( af(3).af.freq, NUM_BIN , 100 );
NUM_BIN = 14;
[SED(3).SED.DOSX SED(3).SED.DOSY] =...
    m_dos( SED(3).SED.freq , NUM_BIN , 1000 );
%--------------------------------------------------------------------------

subplot(3,1,1),...
    plot(...
    SED(1).SED.DOSX,SED(1).SED.DOSY,...
    af(1).af.DOSX,af(1).af.DOSY...
    )
subplot(3,1,2),...
    plot(...
    SED(2).SED.DOSX,SED(2).SED.DOSY,...
    af(2).af.DOSX,af(2).af.DOSY...
    )
subplot(3,1,3),...
    plot(...
    SED(3).SED.DOSX,SED(3).SED.DOSY,...
    af(3).af.DOSX,af(3).af.DOSY...
    )

% m_dos_alloy_vc_gamma_3_createfigure(...
%     X1, Y1,...
%     X2, Y2,...
%     X3, X4,...
%     Y3, X5,...
%     X6, Y4)

% plot(...
%     SED.DOSX,SED.DOSY,...
%     af.DOSX,af.DOSY...
%     )

% m_dos_alloy_vc_gamma_createfigure(...
%     SED.DOSX,...
%     SED.DOSY,...
%     af.DOSX,...
%     af.DOSY...
%     )





