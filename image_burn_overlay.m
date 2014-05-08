% Applies indexed overlay data to an RGB image

function image = image_burn_overlay(image, overlay_data, overlay_origin, overlay_size, color_index_RGB_table)
% Assumes overlay_data strictly covers image

for i = 1:overlay_size(1)
    for j = 1:overlay_size(2)
        if overlay_data(i+overlay_origin(1)-1, j+overlay_origin(2)-1)
            image(overlay_size(2)-j+1, i, :) = color_index_RGB_table(overlay_data(i+overlay_origin(1)-1, j+overlay_origin(2)-1), :);
        end
    end
end