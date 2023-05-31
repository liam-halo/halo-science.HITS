function binary_volume = reconstruct_bitmap(bitmap, PTO)
    %%
    volume = PTO(4:end)';
    
    binary_bitmap = dec2bin(bitmap);
    binary_bitmap = (binary_bitmap == '1')';
    binary_bitmap = binary_bitmap(:);

    numel_disparity = length(binary_bitmap) - prod(volume);

    cropped_bitmap = binary_bitmap(1 + numel_disparity:length(binary_bitmap));
    
    reconstruction_bitmap = circshift(cropped_bitmap, 0);
    
    binary_volume = reshape(reconstruction_bitmap, volume([1 2 3]));
    
    subplot(1,3,1);    
    imagesc(squeeze(sum(binary_volume, 1)));
    title("X");
    axis square; axis tight
    
    subplot(1,3,2);    
    imagesc(squeeze(sum(binary_volume, 2)));
    title("Y");
    axis square; axis tight
    
    subplot(1,3,3);    
    imagesc(squeeze(sum(binary_volume, 3)));
    title("Z");
    axis square; axis tight
    
    
%     binary_volume = reshape(binary_bitmap(1:length(binary_bitmap) - numel_disparity),volume);
        
end