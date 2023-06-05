function output = get_nested_dicos_fields(field_list, struct_input)
    
%     field_list = ["PTORepresentationSequence", "ThreatROIVoxelSequence", "ThreatROIBase"];
    
    for level = 1:length(field_list)
        
        struct_input = skip_mid_level(struct_input);
        
        field_valid = isfield(struct_input, field_list(level));
        final_level = level == length(field_list);
        
        if ~field_valid
            output = [];
            disp("Struct levels invalid at " + field_list(level));
        end
        
        if final_level
            output = struct_input.(field_list(level));
        else
            struct_input = struct_input.(field_list(level));
        end
        
        
    end
    
end