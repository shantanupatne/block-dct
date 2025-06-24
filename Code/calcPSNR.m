function [out] = calcPSNR(img, ref)
%   calcPSNR    computes the PSNR of the reconstructed image
%   
%   img         size: (512, 512), reconstructed image
%   ref         size: (512, 512), reference original image
%
%   out         calculated PSNR value
%



    diff = ref - img;
    mse = mean(diff.^2, "all");
    peak = 255^2;
    out = 10 * log10(peak/mse);
end