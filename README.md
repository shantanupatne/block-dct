# Block DCT Compression in MATLAB

This project creates an image compression system using the 2-D DCT via the following steps:
1. Segment the image into 8 x 8 non-overlapping pixel blocks.
2. Apply the 2-D DCT independently to each block.
3. Set 50%, 75%, 90%, and 95% of the coefficients in each block to zero.
4. For the remaining coefficients, quantize each using an 8-bit uniform scalar quantizer.

Also computes the total number of bits used to code the image, the average number of bits per pixel, and the peak signal-to-noise ratio (PSNR).
