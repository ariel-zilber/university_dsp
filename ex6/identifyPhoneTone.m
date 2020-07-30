
%identifyPhoneTone we are return -1 if we are not found a number from the
%pad.
function [number] = identifyPhoneTone(x, fs)
%% definitions %%
f_row = [697 770 852 941];
f_column = [1209 1336 1477];
phonePad = [ [1 2 3];
            [4 5 6];
            [7 8 9];
           [10 0 11] ];
       

%% plot graph for Frequency Vs Amplitude
yHat = fft(x);
yHat_after_shifting = abs(fftshift(yHat));
th = -pi:(2*pi)/(length(yHat)-1):pi;

omega = th*fs;
hold on
plot(omega/(2*pi),yHat_after_shifting);
xlabel('Frequency[Hz]');
ylabel('Amplitude (V) ' );
title('Frequency Domain Signal');
hold off

%% find peaks after fft and their freq
peaker1 = findpeaks(yHat_after_shifting); %Find local maxima
m1 = max(peaker1); %find the max maxima

peaker1_without_max_peak = peaker1(peaker1~=m1); 
m2 = max(peaker1_without_max_peak);

[y1]=find(yHat_after_shifting==m1);
[y2]=find(yHat_after_shifting==m2);

Frequency_Domain = th*fs/(2*pi);
find_peaks_freq1 = abs(Frequency_Domain(y1));
find_peaks_freq2 = abs(Frequency_Domain(y2));

if abs(find_peaks_freq1(1)) >= abs(find_peaks_freq2(1))
    high_val = find_peaks_freq1;
    low_val = find_peaks_freq2;
else
    high_val = find_peaks_freq2;
    low_val = find_peaks_freq1;
end

number = -1; 
%% find the pad number
offset = floor(abs(high_val(1) - high_val(2)))+1;
index1_on_pad_hi = findTone(high_val(1),f_column,offset);

offset = floor(abs(low_val(1) - low_val(2)))+1;
index2_on_pad_low = findTone(low_val(1),f_row,offset);

if index2_on_pad_low > -1 && index1_on_pad_hi > -1
        number = phonePad(index2_on_pad_low,index1_on_pad_hi);
end
    
    
%%
function ind =  findTone(original, pad, offset)
% we will look for (original - pad)<offset to find the closest tone on the pad to the
% tone we found:
ind = -1;
for i=1:length(pad)
    if abs(original-pad(i))<offset
        ind=i;
    end
end
end
end