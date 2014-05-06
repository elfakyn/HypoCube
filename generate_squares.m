function generate_squares(X_MAX, Y_MAX)

% Generates all unique squares (and their corresponding point value) that can be created on the board.
% Probably not very efficient, but this needs to run only once.

% Positively angled (dx > 0, dy > 0)
% ...X.
% X....
% .....
% ....X
% .O... % O represents spot that has x0, y0.
% Here, dx = 3, dy = 1
%
% Negatively angled (delta_x > 0, delta_y <= 0)
% .X...
% ....X
% .....
% O....
% ...X.
% Here, dx = 3, dy = -1

count = 0;
% Count all unique squares so we can pregenerate the array.
for dx = 1 : min(X_MAX, Y_MAX) - 1 % All possible x sizes
    for dy = -dx+1 : 0 % Negatively angled
        for x0 = 1 : X_MAX - dx + dy
            for y0 = 1 - dy : Y_MAX - dx
                count = count + 1;
            end
        end
    end
    for dy = 1:dx % Positively angled
        for x0 = 1 + dy : X_MAX - dx
            for y0 = 1 : Y_MAX - dx - dy
                count = count + 1;
            end
        end
    end
end

squares = zeros(count, 5); % position 1, position 2, position 3, position 4, points

% Now generate the squares
for dx = 1 : min(X_MAX, Y_MAX) - 1 % All possible x sizes
    for dy = -dx+1 : 0 % Negatively angled
        points = square_points(dx, dy); % Temporary variable to store the points of each generated square
        for x0 = 1 : X_MAX - dx + dy
            for y0 = 1 - dy : Y_MAX - dx
                squares(count,:) = generate_square(X_MAX, Y_MAX, x0, y0, dx, dy, points);
                count = count - 1;
            end
        end
    end
    for dy = 1:dx % Positively angled
        points = square_points(dx,dy);
        for x0 = 1 + dy : X_MAX - dx
            for y0 = 1 : Y_MAX - dx - dy
                squares(count,:) = generate_square(X_MAX, Y_MAX, x0, y0, dx, dy, points);
                count = count - 1;
            end
        end
    end
end

csvwrite(sprintf('pregenerated_squares/squares_%d_%d.csv', X_MAX, Y_MAX), squares);

end

% Function that calculates the point value of each square
function points = square_points(dx, dy)

points = (abs(dx) + abs(dy) + 1)^2;

end

% Generates a row entry corresponding to a certain square
function row = generate_square(X_MAX, Y_MAX, x0, y0, dx, dy, points)

row = [ sub2ind([X_MAX, Y_MAX], x0, y0) ...
    , sub2ind([X_MAX, Y_MAX], x0 + dx, y0 + dy) ...
    , sub2ind([X_MAX, Y_MAX], x0 + dx - dy, y0 + dx + dy) ...
    , sub2ind([X_MAX, Y_MAX], x0 - dy, y0 + dx) ...
    , points ...
    ];

end