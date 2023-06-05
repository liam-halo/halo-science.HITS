function [file_data, execution_time] = import_IDSS_data(index, time_flag)

    directory = dir("G:\Shared drives\DATA_EXTERNAL\HXT26420210009\BOS 2023\BOS Processed Data 2023 (04-02 to 04-12)\2023-04-12\*.tdr.dcs");
    
    filepaths = string(fullfile({directory.folder}, {directory.name}));
    
    [file_data, execution_time] = time_function(@(x) dicominfo(x, 'UseDictionaryVR', true), ...
                                filepaths(index),...
                                time_flag);
%     file_data = dicominfo(filepaths(index), 'UseDictionaryVR', true);
    
    disp("Imported file " + index + "/" + length(filepaths));
    disp("File contains " + length(fieldnames(file_data.ThreatSequence)) + " PTOs");
    
end