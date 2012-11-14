function si = m_si
% lj = m_lj returns an si structrue with si parameters
%--------------------------------------------------------------------------             
si.mass = 28.0855;  

si.sound_expt =8433;
si.sound =...
    ((2/3)*4.48797 + (1/3)*8.39012)*1000;
si.sound_goic =...
    ((2/3)*4.4887 + (1/3)*8.002)*1000;
si.sound_used =...
    ((2/6)*4.4887 + (1/6)*8.002 + (2/6)*1.800 + (1/6)*5.164 )*1000;

si.alat = 5.43E-10;

si.num_atom_ucell=8;
si.num_density = (si.num_atom_ucell / (si.alat^3));

end
%--------------------------------------------------------------------------	


