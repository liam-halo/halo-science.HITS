function output = check_timer(flag, segment)

    if ~exist("segment", 'var')
        segment = "";
    else
        segment = " " + segment;
    end

    if flag
        output = toc;
        disp(prefix('DEBUG') + "Elapsed time for segment" + segment + ": " + output + "s.");
    else
        output = [];
    end
end