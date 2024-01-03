
%% Parameter setting
% antennas' position relative to the first antenna
% each row is the x, y, and z position of each antenna
% the unit is half-wavelength
ant_pos = [ [0  0  0 ]; ...  % (x1,y1,z1)
            [1  0  0 ]; ...  % (x2,y2,z2)
            [1  1  0 ]; ...  % (x3,y3,z3)
            [0  1  0 ] ];    % (x4,y4,z4)

ele_table = [0:1:90];        % elevation of the estimation area
azi_table = [0:1:359];       % azimuth of the estimation area


%% Obtain remain parameters: the steering vector of the estimation area
a = repmat(ele_table,length(azi_table),1);
aoa_table = [];
aoa_table(:,1) = a(:);
aoa_table(:,2) = repmat(azi_table',length(ele_table),1); % all AoA of the estimation area = [elevation azimuth]
phase_table = Steering(ant_pos, aoa_table);              % steering vector of the estimation area

set_array.ant_num     = size(ant_pos,1);
set_array.ant_pos     = ant_pos;
set_array.aoa_table   = aoa_table;
set_array.phase_table = phase_table;

clear a ant_pos ele_table azi_table aoa_table phase_table 
