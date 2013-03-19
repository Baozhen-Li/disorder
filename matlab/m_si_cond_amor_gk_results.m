function gk = m_si_cond_amor_gk_results
%VC = m_lj_alloy_nmd_vc_results
%returns the vc thermal conductivity results @ 10K for 4-12x systems
%--------------------------------------------------------------------------

gk.size =[...
%    2
    2
%    5
    5
    8
    22.845
    2*22.845
    100000000
    ];

gk.num_atoms =[...
%    216
    216
%    1000
    1000
    4096
    100000
    8*100000
    ];

gk.cond =[...
%    1.3747
    1.4517
%    1.4873
    1.6362
    1.7257
    1.958
    2.016
    2.075
    ];

gk.extrap=[...
    1
    ];

%0.05: plot(1./[26 34 42 10000000],1./[14.91 15.59 15.83 16.7],'.')
%0.5: plot(1./[26 34 42 10000000],1./[6.424 7.704 7.728 7.83],'.')


end
