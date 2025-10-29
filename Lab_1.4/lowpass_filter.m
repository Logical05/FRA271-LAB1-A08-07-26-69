function filtered = lowpass_filter(signal, order, sampling_freq, cutoff_freq, show)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    signal;
    order;
    sampling_freq;
    cutoff_freq;
    show = false;
end

df = designfilt('lowpassfir', 'FilterOrder', order, ...
                'CutoffFrequency', cutoff_freq, ...
                'SampleRate', sampling_freq);
filtered = filtfilt(df, signal);

if show
    filterAnalyzer(df)
end

end