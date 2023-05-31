function data = import_scan_data(dictionary, scan_index)
    
    dict = dictionary(scan_index,:);
    
    assert(all_fields_populated(dict), "Insufficient Fields Populated in Dictionary"); 
    
    data = struct();
    data.OOID = dict.OOID;
    data = extract_tdr_info(data, dict.HXT_tdr);

    data.ARC = create_ARC_projections(dict);    
        
end