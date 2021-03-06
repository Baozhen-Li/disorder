
%Number of Particles
numparticles=256;

dt = 0.002;


%MSD File Location
str = strcat('D:\CMU\work\Phonons\LJArgon\Solid\amorphous\quench\NVT-NVT-NVT\0K_300K_0K\nptheatmsd.1');
data1= readmsd_Ar(str);

%Set times
MSD(1:length(data1.timestep),1) = data1.timestep(1,:)*dt;

%Calcualte MSD
for i=1:length(data1.timestep)
MSD(i,2) = mean(data1.atom_data(:,i));  
%MSD(i,3) = mean(data2.atom_data(:,i));
%MSD(i,4) = mean(data3.atom_data(:,i));
end

%plot(MSD(:,1),MSD(:,2),'.',MSD(:,1),MSD(:,3),'.',MSD(:,1),MSD(:,4),'.')
plot(MSD(:,1),MSD(:,2),'.')

pause

%dlmwrite('D:\CMU\vasp\Juarez\GeTe\GeTe_Pot_Structures\DRS_ZB_DRSVaryCellSize\MD\32\5000K\nvt\1000K\nve_msd\MSD_matlab.dat',MSD);