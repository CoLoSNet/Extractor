function PlotResult(sim, est, p)

% Function: plot results
% Input:
%       sim: parameters from Wireless Insite
%       est: parameters from estimation
%       p: creat new figure

%%
figure(p)

% ground truth
gt_gain  = sim.path_gain;     % gain (linear)
gt_delay = sim.path_delay;    % delay (sec)
gt_ele   = sim.path_AOA_ver;  % elevation AoA (rad)
gt_azi   = sim.path_AOA_hor;  % azimuth AoA (rad)

% estimation
est_gain  = abs(est.Gain);
est_delay = est.Delay;
est_ele   = est.AOA_ele;
est_azi   = est.AOA_azi;

%% Plot
subplot(1,3,1) % delay
stem(gt_delay,  gt_gain,  'o', 'Color', 'k', 'LineWidth', 2, 'MarkerSize', 10); hold on
stem(est_delay, est_gain, 'x', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10); hold off
xlabel('Delay (second)','fontsize',12,'fontweight','bold');
ylabel('Magnitude','fontsize',12,'fontweight','bold')
legend('ground truth','estimation')

subplot(1,3,2) % elevation AoA
pp = polar(gt_ele,  gt_gain,  'o'); set(pp, 'Color', 'k', 'LineWidth', 2, 'MarkerSize', 10); hold on
pp = polar(est_ele, est_gain, 'x'); set(pp, 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10); hold off
axis image;

subplot(1,3,3) % azimuth AoA
pp = polar(gt_azi,  gt_gain,  'o'); set(pp, 'Color', 'k', 'LineWidth', 2, 'MarkerSize', 10); hold on
pp = polar(est_azi, est_gain, 'x'); set(pp, 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10); hold off
axis image;

end
