%% HITS Process

clc; clear; close all;
addpath(genpath(cd));
addpath(genpath("G:\My Drive\GitHub\halo-science.toolbox"));
time_run = true;

file_index = 16;

% Initialise Parameters
options = time_function(@init_parameters, [], 1);

bytestream = time_function(@getByteStreamFromArray, options, 1);
options = time_function(@getArrayFromByteStream, bytestream, 1);

% Load File Data
[file_data, load_time] = import_IDSS_data(file_index, time_run);

% Parse Threat Data
threats_compiled = time_function(@parse_threat_data, file_data.ThreatSequence, time_run);






%% Runtime Tests

clc; clear; close all;
addpath(genpath(cd));
addpath(genpath("G:\My Drive\GitHub\halo-science.toolbox"));
time_run = true;
options = init_parameters();

N = 25601;

runtime_table = table();

for file_index = 1:N
    
    try
    [file_data, load_time] = import_IDSS_data(file_index, time_run);

    % Parse Threat Data
    threats_compiled = parse_threat_data(file_data.ThreatSequence);

    runtime_table.file_index(file_index) = file_index;
    runtime_table.load_time(file_index) = load_time;
    runtime_table.PTO_number(file_index) = size(threats_compiled,1);
    runtime_table.ANOMALY_number(file_index) = sum(string(threats_compiled.threat_category) == "ANOMALY");
    runtime_table.threat_number(file_index) = sum(string(threats_compiled.ATDFlag) == "THREAT");  
    
    disp(file_index + "/" + N);
    catch
        disp(file_index + "/" + N + " failed");
    end
    
end

subplot(2,2,1);
histogram(runtime_table.load_time);
xlabel("Loading time (s)");
ylabel("Counts");

subplot(2,2,2)
histogram(runtime_table.PTO_number);
xlabel("PTO Number");
ylabel("Counts");

subplot(2,2,3)
histogram(runtime_table.ANOMALY_number);
xlabel("Anomaly Number");
ylabel("Counts");

subplot(2,2,4)
histogram(runtime_table.threat_number);
xlabel("Threat Number");
ylabel("Counts");



