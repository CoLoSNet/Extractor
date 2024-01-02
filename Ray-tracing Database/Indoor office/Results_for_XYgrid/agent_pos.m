function  [Agent_set] = agent_pos(Agent_set, initial, len, inter)

inter2 = round(1/inter);
col_1 = repmat([0:len(1)*inter2]', floor(len(2)*inter2)+1, 1)*inter + initial(1);
col_2 = repmat([0:len(2)*inter2] , floor(len(1)*inter2)+1, 1)*inter + initial(2);
Agent_set = [Agent_set ; [col_1 col_2(:)]];

end