function file_data = import_IDSS_data(index)

    directory = dir("G:\Shared drives\DATA_EXTERNAL\HXT26420210009\BOS 2023\BOS Processed Data 2023 (04-02 to 04-12)\2023-04-12\*.tdr.dcs");
    
    filepaths = string(fullfile({directory.folder}, {directory.name}));
    
    file_data = dicominfo(filepaths(index), 'UseDictionaryVR', true);
    
    disp("Imported file " + index + "/" + length(filepaths));

end