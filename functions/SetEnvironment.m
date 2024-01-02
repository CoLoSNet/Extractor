
%% Parameter setting
% choose an environment for simulation. The currently proposed environments are
% (1) Indoor office
% (2) Indoor shopping mall
environment = 'Indoor office';  

% plot environment and result or not? PLOT = 0: no, PLOT = 1: yes
PLOT = 1; 

% choose the index of the anchor
% (1) 'all': simulation with all anchors 
% (2) you can enter the index of the anchors after you see the map.png in the environment¡¦s folder
TX_index = 'all';

% choose to simulation mode
% (1) 'all': simulation with all agents 
% (2) 'trajectory': simulation with agents on randomly generated trajectories.
RX_mode = 'all';
traj_num = 1;
traj_len = 1;

%% Obtain remain parameters: the position of agents and anchors
fileNames_cir_case = ['Ray-tracing Database\',environment];
clear environment

cd(fileNames_cir_case)
AgentPositions
AnchorPositions
cd(['..\..\'])

if TX_index == 'all'
    TX_index = 1:Anchor_num;
end

switch RX_mode
    case 'all'
        Traj_index = 1:Agent_num;
    case 'trajectory'
        Traj_index = gen_trajectory(Anchor_pos, Agent_pos, inter, traj_num, traj_len);
end

clear inter
    

