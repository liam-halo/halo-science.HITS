function PTO_data = collate_PTO(data, PTO_index)

    PTO_data.base = double(data.threats.PTO_base.("Item_" + PTO_index));
    PTO_data.extents = double(data.threats.PTO_extent.("Item_" + PTO_index));
    PTO_data.bitmap = data.threats.PTO_bitmap.("Item_" + PTO_index);
    PTO_data.Mass = data.threats.Mass.("Item_" + PTO_index);
    PTO_data.Density = data.threats.Density.("Item_" + PTO_index);
    PTO_data.Zeff = data.threats.Zeff.("Item_" + PTO_index);

end