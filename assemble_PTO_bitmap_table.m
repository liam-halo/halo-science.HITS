% Check Bitmap Health
clc; clear variables; close all;
loadHaloPlugin('');
addpath(genpath(cd));
addpath(genpath("G:\My Drive\GitHub\halo-science.toolbox\Utility"));

dictionary = import_dictionaries("G:\Shared drives\DATA_EXTERNAL\IDSS\2023-04-27\");    

%%

ROI_table = table();

for scan_index = 1:size(dictionary, 1)

    try
        data = import_scan_data(dictionary, scan_index);
    catch
        disp("Data from scan " + scan_index + " not loaded");
        continue
    end
    
    for PTO_index = 1:length(fieldnames(data.threats.PTO_base))

        try
            PTO_data = collate_PTO(data, PTO_index);
            binary_volume = reconstruct_bitmap(PTO_data.bitmap, double([PTO_data.base', PTO_data.extents']'));
            roistats = regionprops3(imdilate(binary_volume, strel('sphere', 3)), 'all');
            
            
            ROI_table_row = roistats(1,:);
            ROI_table_row.scan = scan_index;
            ROI_table_row.PTO = PTO_index;
%             ROI_table_row.volume = sum(ROI_table_row.Image{:}(:));
%             ROI_table_row.pixel_connectivity = {convn(ones(3), ROI_table_row.Image{1})};
%             ROI_table_row.SA = sum(ROI_table_row.pixel_connectivity{1}(:) < 4 & ROI_table_row.pixel_connectivity{1}(:) > 0);
            
            ROI_table = [ROI_table; ROI_table_row];
            disp("Scan " + scan_index + " PTO " + PTO_index + " added to table");
            
        catch
            disp("Data from scan " + scan_index + " not assembled");
            continue
        end        
    end
    
end
