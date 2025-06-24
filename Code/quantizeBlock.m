function [quantized_images, unquantized_images] = quantizeBlock(images)
% quantizeBlock quantize the image blocks. Separately quantize first pixels
%               then quantize the rest values in the block
%
%   images              (8,8,4096) input dct blocks
%   quantized_images    (8,8,4096) forward quantized blocks
%   unquantized_images  (8,8,4096) reconstructed dct blocks


    num_bits = 8;
    quant_levels = 2^num_bits;
    quantized_images = zeros(size(images));
    unquantized_images = zeros(size(images));
    
    % Quantize the (1,1) pixels of all images together
    first_pixels = images(1, 1, :);
    min_first_pixel = min(first_pixels(:));
    max_first_pixel = max(first_pixels(:));
    delta_first_pixel = (max_first_pixel - min_first_pixel) / quant_levels;
    quantized_first_pixels = round((first_pixels/delta_first_pixel) + 0.5);
    unquantized_first_pixels = quantized_first_pixels * delta_first_pixel;
    
    for k = 1:size(images, 3)
        non_zero_elements = images(:,:,k);
        non_zero_elements = non_zero_elements(non_zero_elements ~= 0);
        non_zero_elements(1) = [];  % Exclude (1,1) pixel
        
        min_val = min(non_zero_elements);
        max_val = max(non_zero_elements);
        delta = (max_val - min_val) / quant_levels;
        
        quantized_image = images(:,:,k);
        unquantized_image = quantized_image;
        for i = 1:numel(non_zero_elements)
            quantized_value = round((non_zero_elements(i)/delta) + 0.5);
            quantized_image(quantized_image == non_zero_elements(i)) = quantized_value;
            unquantized_image(unquantized_image == non_zero_elements(i)) = quantized_value * delta;
        end
        
        % Save the quantized image
        quantized_images(:,:,k) = quantized_image;
        quantized_images(1,1,k) = quantized_first_pixels(:,:,k);

        % Save the unquantized image
        unquantized_images(:,:,k) = unquantized_image;
        unquantized_images(1,1,k) = unquantized_first_pixels(:,:,k);
    end
end
