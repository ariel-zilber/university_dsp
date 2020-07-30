function [seq] = identifyPhoneSeq(filename)
    [x, fs_1]=audioread(filename);
    counter = 1;
    maxi = 0;
    % The for finds the maximum of the signal from the file.
    for i = 1:1:length(x)
        if(x(i) > maxi)
            maxi = x(i);
        end
    end
    siglen = 0.1 * fs_1; % Calculates the lentgh of a single signal.
    signal = linspace(0, 1, siglen);
    min = maxi / (sqrt(2)); % The low threshold.
    a = 1;
    while a < length(x)
        if(x(a) < min)
            a = a + 1;
            continue;
        end
        for j = 1:siglen
            signal(j) = x(a + j - 1);
        end
        seq(counter) = identifyPhoneTone(signal, fs_1);
        counter = counter + 1;
        a = a + siglen + 1;
    end
end

