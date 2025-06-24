function [image_out] = computeIDCT(dct_blocks)
%   computeIDCT Computes the inverse DCT on all blocks in the input
%   
%   dct_blocks  size: (8, 8, 4096), windowed dct coefficients
%   image_out   size: (8, 8, 4096), reconstructed image blocks
%


    [N1, N2, blocks] = size(dct_blocks);
    image_out = zeros(size(dct_blocks));
    % tic;

    for block = 1:blocks
        dct_img = dct_blocks(:,:,block);
        for n1 = 1:N1
            for n2 = 1:N2
                k1 = 0:N1-1;
                k2 = 0:N2-1;
                w1 = [0.5, ones(1, N1-1)];
                w2 = [0.5, ones(1, N2-1)];
                prod = w1' .* w2 .* dct_img .* cos(pi*k1*(2* n1 - 1)/(2*N1)).' .* cos(pi*k2*(2 * n2 - 1)/(2*N2));
        
                image_out(n1, n2, block) = sum(prod, "all") / (N1*N2);
            end
        end
    end
    % toc;
end