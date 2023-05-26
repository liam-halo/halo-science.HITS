function binary_volume = reconstruct_bitmap(bitmap, PTO)
    
    volume = PTO(4:end)';
    
    binary_bitmap = dec2bin(bitmap);
    binary_bitmap = (binary_bitmap == '1')';
    binary_bitmap = binary_bitmap(:);

    numel_disparity = length(binary_bitmap) - prod(volume);

%     binary_volume = reshape(binary_bitmap(numel_disparity+1:end),volume);
    binary_volume = reshape(binary_bitmap(1:length(binary_bitmap) - numel_disparity),volume);
        
end