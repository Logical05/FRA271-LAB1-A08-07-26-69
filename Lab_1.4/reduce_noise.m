%      _                    _ 
%     | |    ___   __ _  __| |
%     | |   / _ \ / _` |/ _` |
%     | |__| (_) | (_| | (_| |
%     |_____\___/ \__,_|\__,_|
%                             
datas = load("data\Good_#1.mat");


%      ____                
%     |  _ \ __ ___      __
%     | |_) / _` \ \ /\ / /
%     |  _ < (_| |\ V  V / 
%     |_| \_\__,_| \_/\_/  
%                          
data = datas.data;
%filtered = reshape(double(datas.data{2}.Values.Data), [data.Length, 1]);
analog = reshape(double(data.Data), [data.Length, 1]);
time = data.Time;


%      _____ _____ _____ 
%     |  ___|  ___|_   _|
%     | |_  | |_    | |  
%     |  _| |  _|   | |  
%     |_|   |_|     |_|  
%                        
n = 1:length(analog);
ts = data.TimeInfo.Increment;   % Timestep
fs = 1/(ts);    % Sampling Frequency

FFT_analog = analog(n);
FFT_time = time(n);
FFT = fft(FFT_analog);

f = (0:length(FFT)-1)' * fs/length(FFT);  % Corresponding frequency array

figure(1);
ax_raw = subplot(2, 1, 1);
ax_fft = subplot(2, 1, 2);
ax = [ax_raw; ax_fft;];

plot_title = ["Raw" "Fourier"];
labal_y = ["Analog" "Magnitude"];
labal_x = ["Time (s)" "Frequency (Hz)"];
plot_y  = [FFT_analog abs(FFT)];
plot_x  = [FFT_time f];
color = 'rgb';

for i = 1:size(plot_y, 2)
    plot(ax(i), plot_x(:, i), plot_y(:, i), color(i));
    grid(ax(i), 'on');
    xlabel(ax(i), labal_x(i));
    ylabel(ax(i), labal_y(i));
    title(ax(i), plot_title(i));
end


%      _                  ____               
%     | |    _____      _|  _ \ __ _ ___ ___ 
%     | |   / _ \ \ /\ / / |_) / _` / __/ __|
%     | |__| (_) \ V  V /|  __/ (_| \__ \__ \
%     |_____\___/ \_/\_/ |_|   \__,_|___/___/
%                                            
cutoff_freq = 0.01;

figure(2);
orders = 0:10:100;
plot(time, analog, 'DisplayName', 'No Filtered')
for i = 1:length(orders)
    hold on;
    order = orders(i);
    if order > 0
        filt = lowpass_filter(analog, order, fs, cutoff_freq);
        plot(time, filt, 'DisplayName', 'Filtered Order ' + string(order));
    end
end

xlabel('Time (s)');
ylabel('Analog');
title('Signal');
legend('Location', 'best');
grid on;
axis equal;
hold off;