function [window] = getWindow(percent)
    n = 0;
    switch(percent)
        case 50
            n = 0;
        case 75
            n = 3;
        case 90
            n = 5;
        case 95
            n = 6;

    end
    window = zeros(8,8);
    for i = 0:7
        j = i + n;
        m = 8 - j;
        if (m < 0) 
            m = 0; 
        end
        if (j > 8) 
            j = 8; 
        end
        window(i+1,:) = [ones(1, m), zeros(1, j)];
    end
end