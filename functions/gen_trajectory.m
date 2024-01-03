function RX_index = gen_trajectory(Anchor_pos, Agent_pos, inter, traj_num, traj_len)

Agent_num   = size(Agent_pos,1);   % number of agents
Anchor_num  = size(Anchor_pos,1);  % number of anchors
orient_list = [0 90 180 270];      % up, right, down, left

index_history  = [];
agent_history  = [];
orient_history = [];

traj = 1;
while traj <= traj_num
    
    index_history  = [];
    agent_history  = [];
    orient_history = [];    
    
    % random start position
    index = randi([1,Agent_num]); % index of the agent
    agent = Agent_pos(index,:);   % position pf the agent
    
    cand_list  = []; % candidate of the new orientation
    index_list = []; % candidate of the next agent's index
    for ii = 1:length(orient_list)
        walk_tmp = rotate_pos([0 inter 0], [0 0 orient_list(ii)]);    % try all orientation
        dis = sum(bsxfun(@minus,Agent_pos,agent+walk_tmp).^2,2).^0.5; % find the nearest next agent
        dis(index) = inf;                                             % cannot stay at the current agent
        [min_d, min_i] = min(dis);
        if min_d < (inter*sqrt(2)*0.9)
            cand_list  = [cand_list  ii];
            index_list = [index_list min_i];
        end
    end
    
    r = randi([1 length(cand_list)]);
    index_next = index_list(r);
    agent_next = Agent_pos(index_next,:);
    orient     = cand_list(r);
    walk       = rotate_pos([0 inter 0], [0 0 orient_list(orient)]);
        
    for step = 1:traj_len
        
        % current step
        index_history(step,1)  = index;
        agent_history(step,:)  = agent;
        orient_history(step,1) = orient;
        
        % next step
        cand_list = [];  index_list = [];
        for ii = [1 2 4]
            walk_tmp = rotate_pos(walk, [0 0 orient_list(ii)]);  % try to go straight, turn right, and turn left
            dif = bsxfun(@minus,Agent_pos,agent_next+walk_tmp/2);
            ang = acosd(dif*walk_tmp' ./ (sum(dif.^2,2).^0.5*inter));
            dis = sum(dif.^2,2).^0.5;
            
            dis(index_next,:) = inf;
            dis(ang>30,:) = inf;       
            [min_d, min_i] = min(dis);
            if min_d<0.6
                switch ii
                    case 1  % If the agent can go straight, it has at least 94% to go straight
                        cand_list  = [cand_list  repmat(orient,1,94)];
                        index_list = [index_list repmat(min_i ,1,94)];
                    case 2  % If the agent can turn right, it has at least 3% to turn right
                        cand_list  = [cand_list  repmat(orient+1,1,3)];
                        index_list = [index_list repmat(min_i   ,1,3)];
                    case 4  % If the agent can turn left, it has at least 3% to turn back
                        cand_list  = [cand_list  repmat(orient-1,1,3)];
                        index_list = [index_list repmat(min_i   ,1,3)];
                end
            end
        end
        
        if length(cand_list)>0
            index = index_next;
            agent = agent_next;
            
            r = randi([1 length(cand_list)]);
            index_next = index_list(r);
            agent_next = Agent_pos(index_next,:);
            orient = cand_list(r);
            if orient>length(orient_list); orient = orient-length(orient_list); end
            if orient==0; orient = length(orient_list); end
            walk = rotate_pos([0 inter 0], [0 0 orient_list(orient)]);
        else
            break
        end
        
    end
    
    uniq_prob = length(unique(index_history)) / length(index_history);
    if step == traj_len & uniq_prob>0.9
        RX_index(traj,:) = index_history';
        traj = traj+1;        
    end
    
end


