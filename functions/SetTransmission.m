
%% Parameter setting
noise_level = 1e-8;                                     % noise level
fft_num  = 64;                                          % FFT point
sub_num  = 52;                                          % number of the subcarrier
f_subcar = 312.5e3;                                     % subcarrier spacing (Hz)


%% Obtain remain parameters: bandwidth and pilot arrangement
bandwidth = f_subcar*fft_num;                            % bandwidth (kHz)
n_sample  = [-fft_num/2:fft_num/2-1].'/fft_num;          % subcarriers' frequency divided by bandwidth
sub_loc   = [fft_num/2-ceil(sub_num/2)+1 : fft_num/2 ... % index of the pilot on a symbol
             fft_num/2+2 : fft_num/2+floor(sub_num/2)+1];
clear f_subcar sub_num
