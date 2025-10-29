%      _                    _ 
%     | |    ___   __ _  __| |
%     | |   / _ \ / _` |/ _` |
%     | |__| (_) | (_| | (_| |
%     |_____\___/ \__,_|\__,_|
%                             
datas = [load("data\Good_#1.mat") load("data\Reverse_Good_#1.mat") load("data\Reverse_Good_#2.mat")];
ranges = [
    50 400;
    550 850;
    950 1200;
    1300 1550;
    1650 1800;
    2000 2250;
    2400 2575;
    2700 2900;
    3000 3350;
    3450 3700;
    3850 4250;
    4400 4700;
    4850 5150;
    5300 5500;
    5650 5950;
    6050 6350;
    6450 6750;
    6850 7150;
    7250 7550;
    7700 8000;
    8100 8400;
    2870 3040;
    2770 2820;
    2660 2720;
    2580 2610;
    2500 2530;
    2420 2450;
    2330 2380;
    2230 2290;
    2160 2190;
    2090 2110;
    2010 2050;
    1910 1960;
    1810 1850;
    1740 1760;
    1660 1690;
    1560 1620;
    1450 1500;
    1340 1390;
    1250 1290
    875 1175;
    540 780;
    7900 8150;
    7550 7775;
    7275 7425;
    6975 7150;
    6675 6875;
    6375 6550;
    6050 6250;
    5750 5925;
    5400 5625;
    5150 5300;
    4700 5000;
    4400 4600;
    4050 4250;
    3780 3940;
    3575 3675;
    3150 3450;
    2800 3000;
    2400 2650;
    2000 2250;
    1400 1800;
    540 1250;
];

n = size(datas, 2);
max_m = size(ranges, 1);
m = max_m / n;
result = zeros(m, n);
for i = 1:n
    data = datas(i).data;
    analog = reshape(double(data.Data), [data.Length, 1]);
    time = data.Time;

    Ts = data.TimeInfo.Increment;   % Timestep
    Fs = 1/(Ts);    % Sampling Frequency

    cutoff_freq = 0.01;
    filt = lowpass_filter(analog, 70, Fs, cutoff_freq);
    
    range = ranges(1 + (i - 1) * m:m * i, :);

    range = range.*Fs;
    means = zeros(m, 1);
    for j = 1:m
        means(j) = mean(filt(range(j, 1):range(j, 2)));
    end
    result(:, i) = means;
end
