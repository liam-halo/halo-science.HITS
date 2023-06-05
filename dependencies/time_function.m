function [output, runtime] = time_function(handle, input, time_flag)
    
    start_timer(time_flag);
    output = handle(input);
    runtime = check_timer(time_flag, func2str(handle));

end