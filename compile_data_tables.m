addpath(genpath(cd));
dicomdict("set", fullfile(cd, "dependencies", "core", "dicomDictUpdated.txt"));

directory = dir("D:\HALO-001\HALO\HXT-264\Data");
directory = directory(3:end-2);

datestamp = datetime({directory.name});
cutoff = datetime('2023-04-28');

folderpaths = fullfile({directory.folder}, {directory.name});


for dir_index = 2:length(folderpaths)
    
    if datestamp(dir_index) < cutoff
        options = struct('PRESET', 'IDSS_BOS.1.0');
    else
        options = struct('PRESET', 'IDSS_BOS.1.1');
    end
    
    create_directory_data_table(options, folderpaths(dir_index));

end
