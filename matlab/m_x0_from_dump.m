function x0 = m_x0_from_dump( str_main , str_name , str_name_out )
% x0 = m_x0_from_dump( str_main , str_name )
%write an x0 file in lammps input format
%--------------------------------------------------------------------------

if exist( strcat(str_main,str_name_out) , 'file' )
	str_cmd = ['rm ' str_main str_name_out ]
	system( str_cmd );
end

data = m_lmp_readdump_one(strcat(str_main,str_name),-1,3);

x0.x = data.atom_data(:,1);
x0.y = data.atom_data(:,2);
x0.z = data.atom_data(:,3);
x0.m = ones(size(x0.x,1),1);
x0.id = (1:size(x0.x,1))';

%shift coordinates
    x0.x = bsxfun( @minus, x0.x, min(x0.x) );
    x0.y = bsxfun( @minus, x0.y, min(x0.y) );
    x0.z = bsxfun( @minus, x0.z, min(x0.z) );
    
    x0.NUM_ATOMS_UCELL = data.Natoms; x0.NUM_ATOMS = data.Natoms;
    x0.NUM_MODES = x0.NUM_ATOMS*3;
    
    x0.Lx = data.x_bound(2)-data.x_bound(1);
    x0.Ly = data.y_bound(2)-data.y_bound(1);
    x0.Lz = data.z_bound(2)-data.z_bound(1);
    x0.VOLUME = x0.Lx*x0.Ly*x0.Lz;

%output relaxed
    output =...
	[x0.NUM_ATOMS x0.NUM_ATOMS_UCELL x0.Lx x0.Ly x0.Lz];
    x =...
        [ x0.id x0.m x0.x x0.y x0.z ];
    
    dlmwrite( strcat(str_main,str_name_out),...
        output ,'-append','delimiter',' ');
    dlmwrite( strcat(str_main,str_name_out),...
        x ,'-append','delimiter',' ');

end
