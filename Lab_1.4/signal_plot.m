function signal_plot(time, signals, names)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(signals, 2)
    plot(time, signals(:, i), 'DisplayName', names(i));
    hold on;
end

xlabel('Time (s)');
ylabel('Analog');
legend('Location', 'best');
title("Signal")
grid on;
hold off;
end