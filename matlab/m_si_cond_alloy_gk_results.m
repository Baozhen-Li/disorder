function gk = m_si_cond_alloy_gk_results
%VC = m_lj_alloy_nmd_vc_results
%returns the vc thermal conductivity results @ 10K for 4-12x systems
%--------------------------------------------------------------------------
gk.conc =[...
    0.0
    0.05
    0.15
    0.5
    ];
gk.extrap=[...
    507.67
    8.6758
    4.3761
    3.9802
    ];

gk.size =[...
    4
    6
    8
    10
    ];
gk.cond(1,:) =[...
    509.56
    5.812
    2.5403
    2.1176
    ];
gk.cond(2,:) =[...
    492.41
    6.869
    2.9532
    2.2467
    ];
gk.cond(3,:) =[...
    316.69
    6.956
    3.1668
    2.8595
    ];
gk.cond(4,:) =[...
    521.06
    7.183
    3.4325
    2.9422
    ];



end
