function [H] = makeFilter(f, fs, deltaF, numHarmonics)
    n = []; 
    for i = 1:numHarmonics
        n = [n i*f-deltaF/2 i*f+deltaF/2];
    end
    n = n / (fs / 2);
    C = 100;
    H = fir1(C * numHarmonics, n, 'DC-0'); 
end 