function [bpm] = estimateCorruptedBPM(filename)
fs=360;

% get the values
data = load(filename);
data = data.values;


N = length(data);
n = 0:N-1;
fft_res = fft(data);
k = 0:N-1;
k(ceil((N+1)/2)+1:end) = k(ceil((N+1)/2)+1:end) - N;

% all the freqs
f = k*fs/N;

% madata value
[val, x] = max(fft_res(1:ceil((N+1)/2)));

% find the parameters:
f_power = f(x);
B = 2*abs(val/N);
phase = angle(fft_res(x));

% find the original
data = data - (B*cos(2*pi*(f_power/fs)*n + phase));

% find the bpm of the clean signal
bpm = estimateBPM(data);
 end