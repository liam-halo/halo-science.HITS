function convolution = fft_conv(a, b)
    
    x_buffer = min([size(a,2)/2, size(b,2)/2]);
    y_buffer = min([size(a,1)/2, size(b,1)/2]);

    a_pad = size(b) - size(a);
    b_pad = size(a) - size(b);
    
    a_pad(a_pad < 0) = 0;
    b_pad(b_pad < 0) = 0;
    
    a = padarray(a, ceil(0.5*a_pad), 0, 'pre');
    a = padarray(a, floor(0.5*a_pad), 0, 'post');
    
    b = padarray(b, ceil(0.5*b_pad), 0, 'pre');
    b = padarray(b, floor(0.5*b_pad), 0, 'post'); 
    
    a_fft = fftn(a);
    b_fft = fftn(b);
    
    ab_fft = a_fft .* b_fft;
    
    convolution = ifftshift(ifftn(ab_fft));

    convolution = convolution(x_buffer+1 : end-(x_buffer-1), ...
                                y_buffer+1 : end - (y_buffer-1),...
                                :);
    
end