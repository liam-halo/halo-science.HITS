clc; clear variables; close all;
loadHaloPlugin('');
dicomdict("set", fullfile("C:\Us    ers\Beast\Documents\GitHub\halo-science.toolbox\Utility\data management\data compilation functions",...
                            "dependencies",...
                            "core",...
                            "dicomDictUpdated.txt"));
addpath(genpath(cd));
addpath(genpath("C:\Users\Beast\Documents\GitHub\halo-science.toolbox\Utility"));
dictionary = import_dictionaries("D:\HALO-001\HALO\HXT-264\Data");    


%% Import Scan
close all

scan_index = 15336;
data = import_scan_data(dictionary, scan_index);


% Visualise PTOs

PTO_index = 2;

PTO_data.base = double(data.threats.PTO_base.("Item_" + PTO_index));
PTO_data.extents = double(data.threats.PTO_extent.("Item_" + PTO_index));
PTO_data.bitmap = data.threats.PTO_bitmap.("Item_" + PTO_index);
PTO_data.Mass = data.threats.Mass.("Item_" + PTO_index);
PTO_data.Density = data.threats.Density.("Item_" + PTO_index);
PTO_data.Zeff = data.threats.Zeff.("Item_" + PTO_index);

binary_volume = reconstruct_bitmap(PTO_data.bitmap, double([PTO_data.base', PTO_data.extents']'));
PTO_overlay = padarray(sum(binary_volume,3), PTO_data.base([2 1]), 0, 'pre') .* permute([1 0 0], [1 3 2]);


figure('WindowState', 'maximized');
subplot(1,2,1)
imagesc(data.ARC.ctProjRotated); hold on
im = imshow(PTO_overlay);
im.AlphaData = (PTO_overlay(:,:,1) > 1) .* 0.3;
rectangle('Position', [PTO_data.base([3 1]); PTO_data.extents([3 1])], 'EdgeColor', [1 0 0]);


subplot(1,2,2)
imagesc(sum(binary_volume, 3));
axis equal; axis tight

