function [est] = CSI_Extraction(set, H, N, noise_level, fft_num, sub_loc, n_sample, bandwidth)

% Function: Parameter setting for NOMP
% Input:
%       set: information of the array
%       H: channel
%       N: noise
%       noise_level: noise level
%       fft_num: FFT point
%       sub_loc: index of the pilot on a symbol
%       bandwidth: bandwidth (kHz)
%       n_sample: subcarriers' frequency divided by bandwidth
% Output:
%       est: extracted parameters

%%
ant_num = set.ant_num;              % number of antenna
sub_num = length(sub_loc);          % number of pilot
H = H(sub_loc,:);                   % channel on the pilots
N = N(sub_loc,:);                   % noise on the pilots
n_sample = n_sample(sub_loc);

est.H = H;
est.SNR = 10*log10(mean(abs(H).^2)./mean(abs(N).^2));

%% Algorithm
OSR_fft = 8;                       % over sampling rate for estimate delay
R_s = 1;                           % times of single refinement
R_c = 3;                           % times of cyclic refinement
f_ind = repmat(n_sample,ant_num,1);

%% Stopping criteria
MinPathNum = 3;                    % minimum path numbers requred to be return from the algorithm
MaxPathNum = max(6, MinPathNum) ;  % maximum path numbers for the algorithm
pathNumRange = [MinPathNum MaxPathNum];
p_fa = 1e-2;                       % false alarm
tau = noise_level * ( log(ant_num*sub_num) - log( log(1/(1-p_fa)) ) ); % threshold

%% NOMP
H = H + N;
[GainList, DelayList, AOAList] = extractPath(H, sub_loc, fft_num, f_ind, OSR_fft, R_s, R_c, tau, pathNumRange, set);

% sorting
[~, IDX]    = sort(abs(GainList), 'descend');
est.Gain    = GainList(IDX);                   % gain (complex)
est.Delay   = DelayList(IDX)/2/pi/bandwidth;   % delay (sec)
est.AOA_ele = AOAList(IDX,1)/180*pi;           % elevation (rad)
est.AOA_azi = AOAList(IDX,2)/180*pi;           % azimuth (rad)

end

