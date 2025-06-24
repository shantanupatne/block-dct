function [] = main(infile)

    image = read_display_lena_image(infile);
    segments = segmentImage(image);

    orig_img = figure();
    subplot(121);
    imshow(image, []);
    title("Original Image");

    subplot(122);
    F = fft2(image);
    imshow(log10(abs(fftshift(F)).^2), []);
    title("FFT of Original Image");
    sgtitle("Original Image");

    % saveas(orig_img, "original_img.png");

    
    windows = [50, 75, 90, 95];
    for j = 1:4
        tic;
        
        win_percent = windows(j);
        fprintf("Window width: %d", win_percent);
        
        window = getWindow(win_percent);

        dct_blocks = computeDCT(segments);
        dct_blocks = window.*dct_blocks;
        
        [quant_blocks, unquant_blocks] = quantizeBlock(dct_blocks);
        total_bits = nnz(quant_blocks)*8
        avg_bits_per_pixel = total_bits/512^2

        image_dct = computeIDCT(unquant_blocks);
        
        new_img = combineSegments(image_dct);
        psnr = calcPSNR(new_img, image)
        toc;

        recon_plots = figure();
        subplot(121);
        imshow(new_img, []);
        colormap("gray");
        axis off;
        title("Reconstructed Image");
        
        subplot(122);
        F = fft2(new_img);
        imshow(log10(abs(fftshift(F)).^2), []);
        title("FFT of reconstructed image");
        
        plot_title = sprintf("Window %d", win_percent);
        sgtitle(plot_title);

        % fname = sprintf("recon_img_win_%d.png", win_percent);
        % saveas(recon_plots, fname);

    end

end