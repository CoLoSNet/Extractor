
Anchor_pos = [];             

% the x and y coordinate of the anchors
Anchor_pos(1,:)  = [ 0.2, -1.6]; 
Anchor_pos(2,:)  = [   3, -1.6];
Anchor_pos(3,:)  = [11.5, -1.9];
Anchor_pos(4,:)  = [19.4, -0.7];
Anchor_pos(5,:)  = [  22, -0.7];
Anchor_pos(6,:)  = [11.8, -8.7];
Anchor_pos(7,:)  = [15.8, -7.8];
Anchor_pos(8,:)  = [20.2,   -8];
Anchor_pos(9,:)  = [ 0.5, -9.5];
Anchor_pos(10,:) = [ 0.6,  -14];

Anchor_pos(:,3) = 2.62;           % the z coordinate of the agents
Anchor_num = size(Anchor_pos,1);  % number of anchors

%% Plot environment
if PLOT==1  
    figure(1)
    plot(Anchor_pos(:,1), Anchor_pos(:,2), '.', 'MarkerSize', 36, 'Color', [155 187  89]/256);
    for aa = 1:Anchor_num
        text(Anchor_pos(aa,1),Anchor_pos(aa,2),num2str(aa), 'HorizontalAlignment', 'center');
    end
    hold off    
  
    All_point = [Anchor_pos ; Agent_pos];
    axis([min(All_point(:,1))-0.6, max(All_point(:,1))+0.6, min(All_point(:,2))-0.6, max(All_point(:,2))+0.6])
    axis equal
    
    showlegend = [cell(1,Anchor_num)  'Anchor'  showlegend];
    fig = get(gca,'Children');
    index = sort(find(~cellfun(@isempty,showlegend)),'descend');
    legend(fig(index),cellstr(showlegend(index)),'Location','northeastoutside')
    
end

clear aa fig index All_point showlegend
