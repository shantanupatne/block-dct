function [dct_out] = computeDCT(segments)
%   computeIDCT Computes the DCT on all blocks in the input
%   
%   segments    size: (8, 8, 4096), segmented image blocks
%   dct_out     size: (8, 8, 4096), computed dct blocks
%

    [N1, N2, blocks] = size(segments);
    dct_out = zeros(size(segments));
    for block = 1:blocks
        img = segments(:,:,block);
        for k1 = 1:N1
            for k2 = 1:N2
                n1 = 0:N1-1;
                n2 = 0:N2-1;
                prod = 4 * img .* cos(pi*(k1 - 1)*(2*n1 + 1)/(2*N1)).' .* cos(pi*(k2 - 1)*(2*n2 + 1)/(2*N2));
                dct_out(k1,k2, block) = sum(prod, "all");
            end
        end
    end
end