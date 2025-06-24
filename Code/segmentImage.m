function [segments] = segmentImage(image)
% segmentImage Segments the input image into 8x8 blocks
%   image = Input image to segment
%   segments = segmented blocks

    segments = zeros(8, 8, 64*64);
    for i = 1:64
        h = (i-1)*64;
        for j = 1:64
            segments(:,:,h+j) = image((i-1)*8 + 1: i*8, (j-1)*8 + 1: j*8);
        end
    end            
end