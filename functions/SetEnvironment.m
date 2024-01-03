
%% Parameter setting
% choose an environment for simulation. The currently proposed environments are
% (1) Indoor NSYSU
% (2) Indoor office
% (3) Indoor shopping mall
environment = 'Indoor NSYSU';  

% plot environment and result or not? PLOT = 0: no, PLOT = 1: yes
PLOT = 1; 

% choose the index of the anchor
% (1) 'all': simulation with all anchors 
% (2) you can enter the index of the anchors after you see the map.png in the environment¡¦s folder
TX_index = 'all';

% choose to simulation mode
% (1) 'XYgrid': simulation with all agents 
% (2) 'RandomTraj': simulation with agents on randomly generated trajectories.
% (3) 'LoadTraj': simulation with agents on designed trajectories.
RX_mode = 'XYgrid';
traj_num = 1;
traj_len = 1;

%% Obtain remain parameters: the position of agents and anchors
switch RX_mode
    case 'XYgrid'
        fileNames_cir_case = ['Ray-tracing Database\',environment,'\XYgrid'];
        load([fileNames_cir_case,'\positions.mat']);
        PlotEnvironment
        Traj_index = 1:Agent_num;
        traj_num = 1;
        traj_len = 1;
    case 'RandomTraj'
        fileNames_cir_case = ['Ray-tracing Database\',environment,'\XYgrid'];
        load([fileNames_cir_case,'\positions.mat']);
        PlotEnvironment
        Traj_index = gen_trajectory(Anchor_pos, Agent_pos, inter, traj_num, traj_len);
    case 'LoadTraj'
        fileNames_cir_case = ['Ray-tracing Database\',environment,'\Trajectory'];
        load([fileNames_cir_case,'\positions.mat']);
        PlotEnvironment
        Traj_index = 1:Agent_num;
        traj_num = 1;
        traj_len = 1;
end


% fileNames_cir_case = ['Ray-tracing Database\',environment];

if TX_index == 'all'
    TX_index = 1:Anchor_num;
end

% switch RX_mode
%     case 'all'
%         Traj_index = 1:Agent_num;
%     case 'trajectory'
%         Traj_index = gen_trajectory(Anchor_pos, Agent_pos, inter, traj_num, traj_len);
% end

clear environment inter
    

