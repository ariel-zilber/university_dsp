
function [bpm] = estimateBPM(x)


t = 50; %sec
%Fs = 360;

counter=0;
countpeaks = findpeaks(x);
thershould =  ( max(countpeaks) + min(countpeaks) )/2;
for i=1:length(countpeaks)
    if countpeaks(i) > thershould
        counter = counter +1;
    end
end
bpm = (60*(counter)/(t));
end