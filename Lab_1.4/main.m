%      _                    _ 
%     | |    ___   __ _  __| |
%     | |   / _ \ / _` |/ _` |
%     | |__| (_) | (_| | (_| |
%     |_____\___/ \__,_|\__,_|
%                             
datas = load("data\Mass_#2.mat");


%      ____                
%     |  _ \ __ ___      __
%     | |_) / _` \ \ /\ / /
%     |  _ < (_| |\ V  V / 
%     |_| \_\__,_| \_/\_/  
%                          
data = datas.data{1}.Values;
filtered = reshape(double(datas.data{2}.Values.Data), [data.Length, 1]);
analog = reshape(double(data.Data), [data.Length, 1]);
time = data.Time;


%      __  __       _       
%     |  \/  | __ _(_)_ __  
%     | |\/| |/ _` | | '_ \ 
%     | |  | | (_| | | | | |
%     |_|  |_|\__,_|_|_| |_|
%                           
Ts = data.TimeInfo.Increment;   % Timestep
Fs = 1/(Ts);    % Sampling Frequency
    
cutoff_freq = 0.01;
filt = lowpass_filter(analog, 70, Fs, cutoff_freq, true);

% Plot Graph
names = ["Raw" "Filtered" "Sim"];

figure(1);
y = [analog filt filtered];
signal_plot(time, y, names)
% Plot Graph