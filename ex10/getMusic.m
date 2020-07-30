
function [y] = getMusic(x, fs, pitch, numHarmonics)
    y = ones(size(x));
    for i = 1:length(pitch)
        n1 = floor(pitch(i,1) * fs) + 1;
        if i ~= length(pitch)
            n2 = floor(pitch(i+1, 1) * fs);        
        else
            n2 = length(x); 
        end
        
        f = pitch(i, 2);
        my_filter = makeFilter(f, fs, 0.01, numHarmonics);
        y(n1:n2) = filter(my_filter, 1, x(n1:n2));
        
    end  
end 
