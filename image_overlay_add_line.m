% Adds a new line to the overlay data
% Assumes it's always within bounds.
function overlay_data = image_overlay_add_line(overlay_data, line, color_index)

% line = [x1, y1; x2, y2]
x1 = line(1,1);
x2 = line(2,1);
y1 = line(1,2);
y2 = line(2,2);

iterations = max(abs(x2 - x1), abs(y2 - y1));

for i = 0:iterations
    current_pixel(2) = round(interpolate(y1, y2, i/iterations));
    current_pixel(1) = round(interpolate(x1, x2, i/iterations));
    overlay_data(current_pixel(1), current_pixel(2)) = color_index;
end

end

function out = interpolate(x1, x2, dx)

out = x1 + (x2-x1) * dx;

end
