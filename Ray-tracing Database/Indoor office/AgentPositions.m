
Agent_pos = [];
inter = 0.2; % distance between the agents

% the x and y coordinate of the agents
Agent_pos = agent_pos(Agent_pos, [  4.2,  -22.6], [2.4, 3.8], inter);
Agent_pos = agent_pos(Agent_pos, [ -5.7,  -19.4], [9.5, 0.5], inter);
Agent_pos = agent_pos(Agent_pos, [-3.75,  -18.4], [0.5, 5.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 0.15,  -18.7], [0.6, 4.8], inter);
Agent_pos = agent_pos(Agent_pos, [  4.1,  -18.4], [  1,   6], inter);
Agent_pos = agent_pos(Agent_pos, [-2.97, -13.55], [3.8, 4.2], inter);
Agent_pos = agent_pos(Agent_pos, [    1,    -12], [2.2, 3.4], inter);
Agent_pos = agent_pos(Agent_pos, [ -2.3,     -9], [2.5, 8.2], inter);
Agent_pos = agent_pos(Agent_pos, [  0.6,   -2.7], [2.5, 2.7], inter);
Agent_pos = agent_pos(Agent_pos, [ 3.45,  -10.2], [  1, 8.5], inter);
Agent_pos = agent_pos(Agent_pos, [  4.7,  -2.35], [  2, 2.2], inter);
Agent_pos = agent_pos(Agent_pos, [  7.2,  -2.35], [  4, 0.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 11.7,   -3.1], [  6,   2], inter);
Agent_pos = agent_pos(Agent_pos, [ 14.1,   -0.6], [5.6, 0.4], inter);
Agent_pos = agent_pos(Agent_pos, [ 18.4,   -6.7], [  1, 4.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 21.4,   -6.7], [  1, 6.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 19.9,   -3.4], [  1,   1], inter);
Agent_pos = agent_pos(Agent_pos, [15.66,  -11.1], [  1, 7.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 17.2,  -7.95], [2.5,   1], inter);
Agent_pos = agent_pos(Agent_pos, [ 20.1,  -11.1], [1.5,   4], inter);
Agent_pos = agent_pos(Agent_pos, [ 11.7,  -11.2], [3.5, 1.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 11.3,  -9.35], [  4,   1], inter);
Agent_pos = agent_pos(Agent_pos, [ 11.3,  -4.47], [  4,   1], inter);
Agent_pos = agent_pos(Agent_pos, [ 14.2,   -7.9], [  1,   3], inter);
Agent_pos = agent_pos(Agent_pos, [ 11.4,   -7.9], [  1,   3], inter);
Agent_pos = agent_pos(Agent_pos, [  4.8,  -11.1], [5.5,   2], inter);
Agent_pos = agent_pos(Agent_pos, [ -5.8,  -22.5], [1.5, 2.5], inter);
Agent_pos = agent_pos(Agent_pos, [   -3,  -22.5], [3.5, 2.5], inter);
Agent_pos = agent_pos(Agent_pos, [    1,  -22.5], [  2, 2.5], inter);
Agent_pos = agent_pos(Agent_pos, [    1,   -5.1], [  2,   2], inter);
Agent_pos = agent_pos(Agent_pos, [  4.8,   -4.4], [  6,   1], inter);
Agent_pos = agent_pos(Agent_pos, [  4.8,   -6.8], [  6,   1], inter);
Agent_pos = agent_pos(Agent_pos, [  9.4,  -5.35], [1.5, 0.5], inter);
Agent_pos = agent_pos(Agent_pos, [  4.8,  -5.35], [1.5, 0.5], inter);
Agent_pos = agent_pos(Agent_pos, [  4.8,  -8.75], [  3, 1.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 22.8,   -3.6], [  1, 3.5], inter);
Agent_pos = agent_pos(Agent_pos, [ 23.5,   -6.2], [2.5,   2], inter);
Agent_pos = agent_pos(Agent_pos, [ 21.9, -11.25], [  4,   4], inter);
Agent_pos = agent_pos(Agent_pos, [    7,   -0.5], [  4, 0.5], inter);
Agent_pos = agent_pos(Agent_pos, [    8,   -7.8], [2.5, 0.6], inter);
Agent_pos = agent_pos(Agent_pos, [ 0.29,  -6.18], [  2, 0.8], inter);
Agent_pos = agent_pos(Agent_pos, [ 0.29,   -7.5], [  1, 1.2], inter);
Agent_pos = agent_pos(Agent_pos, [ 0.29,  -8.45], [  2, 0.8], inter);

Agent_pos(:,3) = 1.2;           % the z coordinate of the agents
Agent_num = size(Agent_pos,1);  % number of agents

%% Plot environment
if PLOT==1  
    figure(1)
    plot(Agent_pos(:,1), Agent_pos(:,2), 's', 'MarkerSize', 5, 'Color', [184 136 136]/256, 'MarkerFaceColor', [184 136 136]/256); hold on
    
    showlegend = [];
    showlegend = cellstr(['Agent'  showlegend]);
end

