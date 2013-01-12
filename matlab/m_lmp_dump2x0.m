function m_lmp_dump2x0(str_main,str_name)
%m_lmp_dump2x0(str_main,str_name)
%-------------------------------------------------------------------------- 

format long

str_main = '/home/jason/disorder/lj/amor/4x/XCORR_AF/220/2_10K_relax/time/';

pos = m_lmp_readdump_one(strcat(str.main,str_name),-1,3);

%dummy = m_lmp_readlog(strcat(str.main,'log_heat_1.lammps'));
%logdata = str2num(dummy.data{2});

%output relaxed
    output =...
	[pos.Natoms pos.Natoms...
	 pos.x_bound(2) pos.y_bound(2) pos.z_bound(2)];

x0.

    x =...
        [ (1:pos.Natoms)' ones(pos.Natoms,1)...
        pos.atom_data(:,1) pos.atom_data(:,2) pos.atom_data(:,3) ];
    
    dlmwrite(strcat(str_main,'x0.data'),...
        output ,'-append','delimiter',' ');
    dlmwrite(strcat(str_main,'x0.data'),...
        x ,'-append','delimiter',' ');

plot3(pos.atom_data(:,1),pos.atom_data(:,2),pos.atom_data(:,3),'.')
    
%--------------------------------------------------------------------------	


