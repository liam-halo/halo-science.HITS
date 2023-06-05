function  ARC = create_ARC_projections(dict)

    scan_info = struct();

    scan_info.dictionary = dict;
    system_inputs.system = "IDSS_BOS_1";
    system_inputs.offsets = [30, 0, -37];
    ARC_data = assemble_ARC_dependencies(scan_info, system_inputs);

    ARC_instance = ARC_1_3_0;
    
    [ARC.ctProjRotated, ~, ~, ~, ~, ~, ~] = ...
                                    ARC_instance.RotateAngle(...
                                                ARC_data.ctProj, ...
                                                ARC_data.ctBaseSliceBW, ...
                                                ARC_data.arcConfigBlob);
    
       [ARC.alnImage, ~, ...
        ARC.bananaBImage, ~, ~, ~, ~] = ARC_instance.ScoreImage(...
                                                ARC_data.deDataArray, ...
                                                ARC_data.hxt264Brightfield, ...
                                                ARC_data.hxt264Darkfield, ...
                                                ARC_data.ctOffsets, ...
                                                ARC_data.arcConfigBlob);
                                            
    disp("ARC Images Reconstructed");
    

end