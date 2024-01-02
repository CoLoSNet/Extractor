
Anchor_pos = [];             

% the x and y coordinate of the anchors
Anchor_pos(1,:)  = [ 12.0, -11.16]; 
Anchor_pos(2,:)  = [ 30.7,   -9.7];
Anchor_pos(3,:)  = [  6.7, -25.65];
Anchor_pos(4,:)  = [ 19.4, -32.85];
Anchor_pos(5,:)  = [ 37.5, -23.35];
Anchor_pos(6,:)  = [  8.3, -38.35];
Anchor_pos(7,:)  = [ 24.5,  -45.1];
Anchor_pos(8,:)  = [ 37.5,  -47.7];
Anchor_pos(9,:)  = [ 16.3,  -64.4];
Anchor_pos(10,:) = [ 27.2, -67.27];
Anchor_pos(11,:) = [  7.6,  -75.4];
Anchor_pos(12,:) = [ 36.0, -76.56];
Anchor_pos(13,:) = [18.15,  -91.6];
Anchor_pos(14,:) = [25.77, -95.36];
Anchor_pos(15,:) = [ 10.9, -110.7];
Anchor_pos(16,:) = [ 29.6, -111.8];

Anchor_pos(:,3) = 4.5;            % the z coordinate of the agents
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
    axis equal
    axis([min(All_point(:,1))-5, max(All_point(:,1))+5, min(All_point(:,2))-5, max(All_point(:,2))+5])
    
    showlegend = [cell(1,Anchor_num)  'Anchor'  showlegend];
    fig = get(gca,'Children');
    index = sort(find(~cellfun(@isempty,showlegend)),'descend');
    legend(fig(index),cellstr(showlegend(index)),'Location','northeastoutside')
    
end

clear aa fig index All_point showlegend
