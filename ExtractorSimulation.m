clear; clc; addpath('functions');

%% Setting
SetEnvironment
SetTransmission
SetAntenna

%% Start simulation
for tx = TX_index
    
    for traj = 1:traj_num
        
        RX_index = Traj_index(traj,:);  
        if PLOT & isequal(RX_mode,'trajectory')
            PlotTrajectory
        end
        
        cnt = 1;
        for rx = RX_index
            
            fprintf('TX = %d, trajectory = %d, RX = %d, ', tx, traj, cnt);
            load([fileNames_cir_case,'\Results_for_Mat\TX', num2str(tx), '\Pt_t',num2str(tx), '_r',num2str(rx),'_cir_doa.mat']);
            
            if isempty(sim.path_gain)
                fprintf([' is empty, ']); % this agent cannot receive any signal from the anchor
            else
                %% Multipath parameters from Wireless Insite
                path_gain    = sim.path_gain;                      % gain (linear)
                path_phase   = sim.path_phase;                     % phase (rad)
                path_delay   = sim.path_delay;                     % delay (sec)
                path_aoa_ele = sim.path_AOA_ver;                   % elevation AoA (rad)
                path_aoa_azi = sim.path_AOA_hor;                   % azimuth AoA (rad)
                path_aoa     = [path_aoa_ele path_aoa_azi]/pi*180; % AoA (degree)
                
                %%  Multipath channel and noise for ideal triangular antenna
                exp_gain  = path_gain.*exp(1j*path_phase);                      % complex gain
                exp_delay = exp(-1j*2*pi*bandwidth*n_sample*path_delay.');      % subcarrier response
                exp_omega = Steering(set_array.ant_pos,path_aoa);               % steering vector
                H = exp_delay*bsxfun(@times,exp_gain,exp_omega);                % channel
                N = sqrt(noise_level)*(randn(fft_num,set_array.ant_num)+1j*randn(fft_num,set_array.ant_num))/sqrt(2);% noise
                
                %% Use three antenna array estimate 3D AoA (elevation + azimuth)
                est_array = CSI_Extraction(set_array, H, N, noise_level, fft_num, sub_loc, n_sample, bandwidth);
                if PLOT; PlotResult(sim, est_array,2); end

            cnt = cnt+1;
                
            end
            fprintf('\n');
            
        end % rx
        
    end
    
end % tx



