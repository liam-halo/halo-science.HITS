function binary_volume = reconstruct_bitmap(bitmap, PTO)
    %%
    volume = PTO(4:end)';
    
    binary_bitmap = dec2bin(bitmap);
    binary_bitmap = fliplr((binary_bitmap == '1'))';
    binary_bitmap = binary_bitmap(:);

    numel_disparity = length(binary_bitmap) - prod(volume);

    cropped_bitmap = binary_bitmap(1:length(binary_bitmap) - numel_disparity);
    
    reconstruction_bitmap = circshift(cropped_bitmap, 0);
    
    binary_volume = reshape(reconstruction_bitmap, volume([1 2 3]));
    
    subplot(2,2,1);    
    isosurface(padarray(binary_volume, [1 1 1], 0));
    title("Reconstructed Volume");
    axis equal; axis tight; view(3); camlight; lighting gouraud;
    
    subplot(2,2,2);    
    imagesc(squeeze(sum(binary_volume, 2)));
    title("Y");
    axis square; axis tight
    
    subplot(2,2,3);    
    imagesc(squeeze(sum(binary_volume, 3)));
    title("Z");
    axis equal; axis tight
    
    subplot(2,2,4);    
    imcontour(sum(binary_volume, 3));
    title("Z Contours"); grid on; grid minor;
    axis equal; axis tight
    
    colormap turbo
        
    
%     binary_volume = reshape(binary_bitmap(1:length(binary_bitmap) - numel_disparity),volume);
        
end