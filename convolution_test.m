clc; clear; close all;
addpath(genpath(cd));

options = init_parameters();

file_index = 24;
file_data = import_IDSS_data(file_index);
PTO_number = length(fieldnames(file_data.ThreatSequence));

%% Visualisation
close all

rownumber = 3;
threat_index = 1;
PTO_Y_index = 3;

threat = extract_threat_information(file_data.ThreatSequence, threat_index);
disp(threat);

if ~isempty(threat.bitmap)
  
    PTO = threat.PTO;
    
    binary_volume = reconstruct_bitmap(threat.bitmap, PTO);

    [beam_model, beam_radius] = init_beam_model(options, PTO, PTO_Y_index);

    tic
    overlap_map = convn(binary_volume, beam_model, 'valid')/sum(beam_model(:));
    [overlap_max.y, overlap_max.x] = find(overlap_map == max(overlap_map(:)));
    overlap_max.x = median(overlap_max.x);
    overlap_max.y = median(overlap_max.y);
    runtime.conv = toc;
    
    
    tic
    overlap_map_fft = fft_conv(binary_volume, beam_model)/sum(beam_model(:));
    overlap_map_fft = overlap_map_fft(:,:,round(size(overlap_map_fft, 3)/2));
    [fft_max.y, fft_max.x] = find(overlap_map_fft == max(overlap_map_fft(:)));
    fft_max.x = median(fft_max.x);
    fft_max.y = median(fft_max.y);
    runtime.fft = toc;    
    
    
    overlap_map_centre = 0.5*size(overlap_map);
    binary_volume_centre = 0.5 * size(binary_volume);

    figure('WindowState', 'maximized');
    subplot(2,3,1);
    imagesc(sum(binary_volume, PTO_Y_index));   
    rectangle('Position', [binary_volume_centre([2 1]), 0, 0] + [-0.5 -0.5 1 1] * min(beam_radius),...
                'EdgeColor', [1 0 0],...
                'Curvature', 1);   
    rectangle('Position', [binary_volume_centre([2 1]), 0, 0] + [-0.5 -0.5 1 1] * max(beam_radius),...
                'EdgeColor', [1 0 0],...
                'Curvature', 1);
    title("PTO " + threat_index + " vertical Image");
    axis equal; axis tight

    
    subplot(2,3,2);
    imagesc(overlap_map);   hold on;
    rectangle('Position', [overlap_map_centre([2 1]), 0, 0] + [-0.5 -0.5 1 1] * min(beam_radius),...
                'EdgeColor', [1 0 0],...
                'Curvature', 1);   
    rectangle('Position', [overlap_map_centre([2 1]), 0, 0] + [-0.5 -0.5 1 1] * max(beam_radius),...
                'EdgeColor', [1 0 0],...
                'Curvature', 1);
    scatter(overlap_max.x, overlap_max.y, 8, 'g', 'filled');
    scatter(overlap_map_centre(2), overlap_map_centre(1), 8, 'r', 'filled');
    plot([overlap_max.x, overlap_map_centre(2)], [overlap_max.y, overlap_map_centre(1)], 'k--');
    title("Beam-PTO Overlap. Runtime: " +runtime.conv + "s");
    axis square; axis tight    


    
    subplot(2,3,3);
    imagesc(overlap_map_fft);   hold on;
    rectangle('Position', [overlap_map_centre([2 1]), 0, 0] + [-0.5 -0.5 1 1] * min(beam_radius),...
                'EdgeColor', [1 0 0],...
                'Curvature', 1);   
    rectangle('Position', [overlap_map_centre([2 1]), 0, 0] + [-0.5 -0.5 1 1] * max(beam_radius),...
                'EdgeColor', [1 0 0],...
                'Curvature', 1);
            
    scatter(fft_max.x, fft_max.y, 8, 'g', 'filled');
    scatter(overlap_map_centre(2), overlap_map_centre(1), 8, 'r', 'filled');
    plot([fft_max.x, overlap_map_centre(2)], [fft_max.y, overlap_map_centre(1)], 'k--');
    
    title("Beam-PTO Overlap FFT. Runtime: " + runtime.fft + "s");
    axis square; axis tight    

    
    subplot(2,3,4);
    scatter(overlap_map_fft(:), overlap_map(:), 8, 'filled'); hold on 
    
    mid.min = min([get(gca, 'XLim'), get(gca, 'YLim')]);
    mid.max = max([get(gca, 'XLim'), get(gca, 'YLim')]);
    plot([mid.min mid.max] , [mid.min, mid.max], 'k--');
    
    xlim([mid.min, mid.max]);
    ylim([mid.min, mid.max]);
    grid on; grid minor;
    xlabel("FFT Conv Value");
    ylabel("Conv Value");
    title("Method Difference");
    
end


