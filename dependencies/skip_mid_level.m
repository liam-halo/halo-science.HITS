function new_level = skip_mid_level(input_struct)
    
    one_field = length(fieldnames(input_struct)) == 1;
    item_1_field = string(fieldnames(input_struct)) == "Item_1";
    
    if one_field && item_1_field
        new_level = input_struct.Item_1;
    else
        new_level = input_struct;
    end
    
end