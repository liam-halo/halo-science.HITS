function threats_compiled = parse_threat_data(ThreatSequence)
    
    threats_compiled = table();

    threats_compiled.base = struct2cell(structfun(@(x)  get_nested_dicos_fields(...
                                            ["PTORepresentationSequence", "ThreatROIVoxelSequence", "ThreatROIBase"],...
                                                x), ThreatSequence, 'UniformOutput', false));

    threats_compiled.extents = struct2cell(structfun(@(x)  get_nested_dicos_fields(...
                                            ["PTORepresentationSequence", "ThreatROIVoxelSequence", "ThreatROIExtents"],...
                                                x), ThreatSequence, 'UniformOutput', false));

    threats_compiled.bitmap = struct2cell(structfun(@(x)  get_nested_dicos_fields(...
                                            ["PTORepresentationSequence", "ThreatROIVoxelSequence", "ThreatROIBitmap"],...
                                                x), ThreatSequence, 'UniformOutput', false));

    threats_compiled.threat_category = struct2cell(structfun(@(x)  get_nested_dicos_fields(...
                                            ["ATDAssessmentSequence", "ThreatCategory"],...
                                                x), ThreatSequence, 'UniformOutput', false));

    threats_compiled.threat_category_description = struct2cell(structfun(@(x)  get_nested_dicos_fields(...
                                            ["ATDAssessmentSequence", "ThreatCategoryDescription"],...
                                                x), ThreatSequence, 'UniformOutput', false));

    threats_compiled.ATDAssessment = struct2cell(structfun(@(x)  get_nested_dicos_fields(...
                                            ["ATDAssessmentSequence", "ATDAbilityAssessment"],...
                                                x), ThreatSequence, 'UniformOutput', false));

    threats_compiled.ATDFlag = struct2cell(structfun(@(x)  get_nested_dicos_fields(...
                                            ["ATDAssessmentSequence", "ATDAssessmentFlag"],...
                                                x), ThreatSequence, 'UniformOutput', false));
end