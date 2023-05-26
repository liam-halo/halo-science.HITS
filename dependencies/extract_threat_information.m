function threat = extract_threat_information(threats, index)
    
    threat_struct = threats.("Item_" + index);
    
    threat.index = index;
    threat.Density = threat_struct.Density;
    threat.Mass = threat_struct.Mass;
    threat.PTO = [threat_struct.PTORepresentationSequence.Item_1.ThreatROIVoxelSequence.Item_1.ThreatROIBase;...
                    threat_struct.PTORepresentationSequence.Item_1.ThreatROIVoxelSequence.Item_1.ThreatROIExtents];
    threat.Density = threat_struct.Density;
    threat.bitmap = threat_struct.PTORepresentationSequence.Item_1.ThreatROIVoxelSequence.Item_1.ThreatROIBitmap;

end