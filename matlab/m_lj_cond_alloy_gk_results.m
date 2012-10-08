function gk = m_lj_gk_alloy_results
%gk = m_lj_gk_alloy_results
%returns the gk thermal conductivity results @ 10K for 4-12x systems
%--------------------------------------------------------------------------

GK(1).conc =[...
    0
    0.05
    0.15
    0.5
    ];

GK(1).size =[...
    4
    6
    8
    10
    12
    ];

GK(1).cond_extrap =[...
3.3
0.75
0.35
0.28
];

GK(1).cond =[...
    3.1306 0.0037589
    3.2109 0.025422
    3.2384 0.067034
    3.1898 0.006479
    3.2405 0.043893
    ];
%extrapolate 3.3
GK(2).cond =[...
    0.73665 0.005542
    0.72065 0.010554
    0.6825 0.0084678
    0.69605 0.01531
    0.78346 0.025184
    ];
%extrapolate 0.75
GK(3).cond =[...
    0.24852 0.0039003
    0.28899 0.0074171
    0.35572 0.005313
    0.31627 0.0047446
    0.34049 0.0052839
    ];
%extrapolate 0.35
GK(4).cond =[...
    0.14186 0.0023053
    0.18193 0.0022253
    0.2153 0.0016606
    0.20421 0.0046493
    0.2367 0.0037717
    ];
%extrapolate 0.28
GK(5).size =[...
    4
    8
    10
    12
    ];

GK(5).conc =[...
    0
    0.05
    0.15
    0.5
    ];

GK(5).cond =[...
    0.16656 0.033505
    0.16844 0.00038194
    0.17869 0.013507
    0.17053 0.0096541
    ];

% plot(...
%     GK(1).size,GK(1).cond(:,1),...
%     GK(1).size,GK(2).cond(:,1),...
%     GK(1).size,GK(3).cond(:,1),...
%     GK(1).size,GK(4).cond(:,1),...
%     GK(5).size,GK(5).cond(:,1)   )
%     
% plot(...
%     GK(1).conc,...
%     [...
%     GK(1).cond(5,1)
%     GK(2).cond(5,1)
%     GK(3).cond(5,1)
%     GK(4).cond(5,1) ],'.',...
%     0.5,...
%     GK(5).cond(4,1)/sqrt(2) )

% lj_alloy_gk_results_createfigure(...
%     GK(1).conc,...
%     [...
%     GK(1).cond(5,1)
%     GK(2).cond(5,1)
%     GK(3).cond(5,1)
%     GK(4).cond(5,1) ],...
%     0.5,...
%     GK(5).cond(4,1)/sqrt(2) )

% VC.cond =[...
%     3.4 0.4 
%     0.83 0.08
%     0.42 0.04
%     0.28 0.05
%     ];
% 
% plot(...
%     GK(1).conc,...
%     [...
%     GK(1).cond(5,1)
%     GK(2).cond(5,1)
%     GK(3).cond(5,1)
%     GK(4).cond(5,1) ],'.',...
%     0.5,...
%     GK(5).cond(4,1)/sqrt(2),...
%     GK(1).conc,VC.cond(:,1),'.'...
%     )

% XCORR.cond =[...
%     3.4 0.0 
%     0.74 0.08
%     0.25 0.20
%     0.05 0.20
%     ];

% semilogy(...
%     GK(1).conc,...
%     [...
%     GK(1).cond(5,1)
%     GK(2).cond(5,1)
%     GK(3).cond(5,1)
%     GK(4).cond(5,1) ],'.',...
%     0.5,...
%     GK(5).cond(4,1)/sqrt(2),'.',...
%     GK(1).conc,VC.cond(:,1),'.',...
%     GK(1).conc,sum(XCORR.cond(:,:),2),'.',...
%     0.5,...
%     0.13/sqrt(2),'.'...
%     )
% 
% semilogy(...
%     GK(1).conc,...
%     XCORR.cond(:,1),'.',...
%     GK(1).conc,...
%     XCORR.cond(:,2),'.',...
%     0.5,...
%     0.13/sqrt(2),'.'... 
%     )

end



    
