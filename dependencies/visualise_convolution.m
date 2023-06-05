

position_change = [round(overlap_max.y) - round(0.5*size(beam_model,2)),...
                                            round(overlap_max.x) - round(0.5*size(beam_model,1))];

beam_pad = position_change .* double(position_change > 0);
pto_pad = -1 * position_change .* double(position_change < 0);
                                        
padded_volume = padarray(binary_volume, [pto_pad + 1, 1], 0);
padded_beam_model = padarray(beam_model, beam_pad, 0, 'pre');

figure();
isosurface(padded_volume);
axis equal; grid minor; hold on;

i2 = patch(isosurface(padarray(padded_beam_model, [1 1 1], 0)));
i2.FaceColor = 'r';


