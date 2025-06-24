function [image] = combineSegments(segments)
% combineSegments Combine all individual image blocks into one image
%   segments        (8,8,4096) input image blocks
%   image           (512, 512) output image
    
    image = zeros(512, 512);
    for i = 1:64
        h = (i-1)*64;
        for j = 1:64
            image((i-1)*8 + 1: i*8, (j-1)*8 + 1: j*8) = segments(:,:,h+j);
        end
    end            
end