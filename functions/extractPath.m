function [GainList, DelayList, AoAList] = extractPath(y, sub_loc, fft_num, f_ind, OSR_fft, R_s, R_c, tau, pathNumRange, set)

% Function: Extract paths from channel
% Input:
%       y: channel
%       sub_loc: index of the pilot on a symbol
%       fft_num: FFT point
%       f_ind: subcarriers' frequency divided by bandwidth
%       OSR_fft: over sampling rate for delay
%       R_s: times of single refinement
%       R_c: times of cyclic refinement
%       tau: stopping criteria threshold
%       pathNumRange: minimum and maximum path numbers for the algorithm
%       set: information of the array
% Output:
%       GainList: complex gain of every path
%       DelayList: delay of every path (unit: 2*pi*bandwidth*second)
%       AoAList: AoA of every path (unit: degree)

%%
if ~exist('pathNumRange','var'), pathNumRange = [1 10];
elseif isempty(pathNumRange), pathNumRange = [1 10]; end
MinPathNum = pathNumRange(1);
MaxPathNum = pathNumRange(2);

[Delay_manifold, AoA_manifold] = preProcessMeasMat(y, fft_num, f_ind, OSR_fft, set);

y_r = y;
pathNum = 1;
GainList  = [];
DelayList = [];
AoAList   = [];

while true
    
    % Coarse Detection State
    [gain_new, delay_new, aoa_new, y_r, res_inf_normSq_rot] = CoarseDetect(y_r, sub_loc, Delay_manifold, AoA_manifold);
    
    % Stopping criterion
    if pathNum <= MaxPathNum
        if (res_inf_normSq_rot > tau) || (pathNum <= MinPathNum)
            gain = gain_new;
            delay = delay_new;
            aoa = aoa_new;
        else
            break;
        end
    else
        break;
    end
    
    % Refinement State
    for i = 1:R_s
        [gain_new, delay_new, aoa_new, y_r] = NewtonRefine(y_r, gain, delay, aoa, Delay_manifold, AoA_manifold);
        gain  = gain_new;
        delay = delay_new;
        aoa   = aoa_new;
    end
    GainList(pathNum,1)  = gain_new;
    DelayList(pathNum,1) = delay_new;
    AoAList(pathNum,:)   = aoa_new;
    
    [GainList, DelayList, AoAList, y_r] = refineAll(y_r, R_s, R_c, GainList, DelayList, AoAList, Delay_manifold, AoA_manifold);
    [GainList, y_r] = solveLeastSquares(y, GainList, DelayList, AoAList, Delay_manifold, AoA_manifold);
    
    pathNum = pathNum + 1 ;
    
end


end

function [Delay_manifold, AoA_manifold] = preProcessMeasMat(y, fft_num, f_ind, OSR_fft, set)

% Gird point of delay
sub_num = size(y,1);
R_fft = OSR_fft*fft_num;
coarseDelay = 2*pi*fft_num*(0:(R_fft-1))/R_fft;

Delay_manifold.sub_num = sub_num;
Delay_manifold.fft_num = fft_num;
Delay_manifold.R_fft   = R_fft;
Delay_manifold.coarse  = coarseDelay;
Delay_manifold.f_ind   = f_ind;

%  Gird point of AOA
R_ant = size(set.phase_table,1);

AoA_manifold.ant_num     = set.ant_num;
AoA_manifold.R_ant       = R_ant;
AoA_manifold.coarse      = set.aoa_table;
AoA_manifold.phase_table = set.phase_table;

end

function  [gain_new, delay_new, aoa_new, y_r, res_inf_normSq_rot] = CoarseDetect(y, sub_loc, Delay_manifold, AoA_manifold)

sub_num     = Delay_manifold.sub_num;
fft_num     = Delay_manifold.fft_num;
R_fft       = Delay_manifold.R_fft;
coarseDelay = Delay_manifold.coarse;
f_ind       = Delay_manifold.f_ind;

ant_num     = AoA_manifold.ant_num;
R_ant       = AoA_manifold.R_ant;
coarseAOA   = AoA_manifold.coarse;
phase_table = AoA_manifold.phase_table;

%%%%%%%%%%%%%%%%%%% find the strongest AoA and ToA (match with gain) %%%%%%%%%%%%%%%%%%%%
Y = zeros(R_fft,ant_num);
Y((R_fft-fft_num)/2 + sub_loc, :) = y;
gains = ifft(ifftshift(Y,1), R_fft)*R_fft;
gains = gains(1:(R_fft/2),:)*phase_table'/sub_num/ant_num; % gains(1:(R_fft/2),:), only estimate the path with small delay
prob  = abs(gains).^2;

[~,IDX]   = max(prob(:));
aoa_ind   = ceil(IDX/(R_fft/2));
delay_ind = IDX-(aoa_ind-1)*(R_fft/2);
delay_new = coarseDelay(delay_ind);
aoa_new   = [coarseAOA(aoa_ind,:), aoa_ind];

a_ind = repmat(phase_table(aoa_ind,:),sub_num,1);
x = exp(-1j*f_ind*delay_new).*a_ind(:);
gain_new = (x'*y(:))/(x'*x);
y_r = y(:) - gain_new * x;

%%
OSR_fft = floor(R_fft/fft_num);
OSR_ant = floor(R_ant/ant_num);
prob_grid = prob(1:OSR_fft:end, 1:OSR_ant:end);
res_inf_normSq_rot = max(prob_grid(:)*sub_num*ant_num);

end

function [gain, delay, aoa, y_r] = NewtonRefine(y_r, gain, delay, aoa, Delay_manifold, AoA_manifold)

sub_num     = Delay_manifold.sub_num;
f_ind       = Delay_manifold.f_ind;
ant_num     = AoA_manifold.ant_num;
coarseAoA   = AoA_manifold.coarse;
phase_table = AoA_manifold.phase_table;

%% origin signal
a_ind = repmat(phase_table(aoa(3),:),sub_num,1);
x = exp(-1j*f_ind*delay).*a_ind(:);
y = y_r + gain*x;

%% delay refine with Newton
dx_delay  = (-j*f_ind).*x;
dx2_delay = (-j*f_ind).^2.*x;

der1 = -2*real(gain*y_r'*dx_delay);
der2 = -2*real(gain*y_r'*dx2_delay) + 2*abs(gain)^2*(dx_delay'*dx_delay);

if der2 > 0
    delay_new = delay - der1/der2;
else
    delay_new = delay - sign(der1)*(1/4)*(2*pi/2048)*rand(1);
end

%% aoa refine
x = reshape(exp(-1j*f_ind*delay_new), sub_num, ant_num);
y_ = reshape(y, sub_num, ant_num);
gains = mean((x' *y_),1);
gains = gains*phase_table'/sub_num/ant_num;
prob  = abs(gains).^2;
[~,aoa_ind] = max(prob(:));
aoa_new = [coarseAoA(aoa_ind,:) aoa_ind];

a_ind = repmat(phase_table(aoa_ind,:),sub_num,1);
x = exp(-1j*f_ind*delay_new).*a_ind(:);
gain_new = (x'*y)/(x'*x);
y_r_new = y - gain_new*x;

if (y_r_new'*y_r_new) <= (y_r'*y_r)
    gain = gain_new;
    delay = delay_new;
    aoa = aoa_new;
    y_r = y_r_new;
end

end

function [GainList, DelayList, AoAList, y_r] = refineAll(y_r, R_s, R_c, GainList, DelayList, AoAList, Delay_manifold, AoA_manifold)

K = length(GainList);

for i = 1:R_c
    order = 1:K;
    
    for j = 1:K
        l = order(j);
        gain  = GainList(l);
        delay = DelayList(l);
        aoa   = AoAList(l,:);
        
        for kk = 1:R_s
            [gain_new,delay_new,aoa_new,y_r] = NewtonRefine(y_r,gain,delay,aoa,Delay_manifold,AoA_manifold);
        end
        GainList(l)  = gain_new;
        DelayList(l) = delay_new;
        AoAList(l,:) = aoa_new;
    end
    
end

end

function [GainList, y_r] = solveLeastSquares(y, GainList, DelayList, AoAList, Delay_manifold, AoA_manifold)

sub_num     = Delay_manifold.sub_num;
f_ind       = Delay_manifold.f_ind;
ant_num     = AoA_manifold.ant_num;
phase_table = AoA_manifold.phase_table;

for ii = 1:size(AoAList,1)
    aoa_ind = AoAList(ii,3);
    a_ind = repmat(phase_table(aoa_ind,:),sub_num,1);
    A_IND(:,ii) = a_ind(:);
end

A =  bsxfun(@times, exp(bsxfun(@times, -1j*f_ind , DelayList.')) , A_IND);
GainList = ((A'*A)\(A'*y(:)));
y_r = y(:) - A*GainList;
y_r = reshape(y_r,sub_num,ant_num);

end

