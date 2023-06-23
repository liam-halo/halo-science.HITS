function [file_data, execution_time] = import_IDSS_data(index, time_flag)

    directory = dir("D:\HALO-001\HALO\HXT-264\Data\**\*.tdr.dcs");
    
    filepaths = string(fullfile({directory.folder}, {directory.name}));
    
    [file_data, execution_time] = time_function(@(x) dicominfo(x, 'UseDictionaryVR', true), ...
                                filepaths(index),...
                                time_flag);
%     file_data = dicominfo(filepaths(index), 'UseDictionaryVR', true);
    
    disp("Imported file " + index + "/" + length(filepaths));
    disp("File contains " + length(fieldnames(file_data.ThreatSequence)) + " PTOs");
    
end