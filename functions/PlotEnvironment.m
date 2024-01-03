if PLOT==1
    figure(1)
    plot(Agent_pos(:,1), Agent_pos(:,2), 's', 'MarkerSize', 5, 'Color', [184 136 136]/256, 'MarkerFaceColor', [184 136 136]/256); hold on
    plot(Anchor_pos(:,1), Anchor_pos(:,2), '.', 'MarkerSize', 36, 'Color', [155 187  89]/256);hold off
    for aa = 1:Anchor_num
        text(Anchor_pos(aa,1),Anchor_pos(aa,2),num2str(aa), 'HorizontalAlignment', 'center');
    end
    
    All_point = [Anchor_pos ; Agent_pos];
    axis([min(All_point(:,1))-0.6, max(All_point(:,1))+0.6, min(All_point(:,2))-0.6, max(All_point(:,2))+0.6])
    axis equal
    
    showlegend = [cell(1,Anchor_num)  'Anchor'  'Agent'];
    fig = get(gca,'Children');
    index = sort(find(~cellfun(@isempty,showlegend)),'descend');
    legend(fig(index),cellstr(showlegend(index)),'Location','northeastoutside')
    clear aa fig index All_point showlegend
end

