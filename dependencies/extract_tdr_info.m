function data = extract_tdr_info(data, HXT_tdr)
    
    tdr = dicominfo(HXT_tdr, 'UseDictionaryVR', true);
    
    threats = tdr.ThreatSequence;
    
    data.threats.PTO_base = structfun(@(x) x.PTORepresentationSequence.Item_1.ThreatROIVoxelSequence.Item_1.ThreatROIBase, threats, 'UniformOutput', false);
    data.threats.PTO_extent = structfun(@(x) x.PTORepresentationSequence.Item_1.ThreatROIVoxelSequence.Item_1.ThreatROIExtents, threats, 'UniformOutput', false);
    data.threats.PTO_bitmap = structfun(@(x) x.PTORepresentationSequence.Item_1.ThreatROIVoxelSequence.Item_1.ThreatROIBitmap, threats, 'UniformOutput', false);
    
    
    data.threats.Mass = structfun(@(x) x.Mass, threats, 'UniformOutput', false);
    data.threats.Density = structfun(@(x) x.Density, threats, 'UniformOutput', false);
    data.threats.Zeff = structfun(@(x) x.ZEffective, threats, 'UniformOutput', false);
    
    
end