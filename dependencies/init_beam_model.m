function [beam_model, beam_radius] = init_beam_model(options, PTO, PTO_Y_index)
    
    y_range = PTO(PTO_Y_index) + [0 PTO(PTO_Y_index + 3)];

    beam_buffer = options.heightoffset + (options.tunnelheight - max(y_range));
    
    beam_radius = (beam_buffer + (1:PTO(PTO_Y_index + 3))) * tand(options.theta/2);
    
    [X,Y] = meshgrid((1:(2*max(ceil(beam_radius)))) - (max(ceil(beam_radius)) + 0.5));
    R = hypot(X,Y);

    beam_model = R < permute(beam_radius, [3 1 2]) + options.beamwidth & ...
                    R > permute(beam_radius, [3 1 2]) - options.beamwidth;
    
end