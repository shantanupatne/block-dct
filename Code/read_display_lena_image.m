function [a] = read_display_lena_image(fname)
    fid = fopen(fname);
    a = fread(fid,[512,512],'uchar');
    fclose(fid);
    a = a';
end