function recalculate_score(move)

global BOARD;
global SCORE;
global TOPLAY;

[x1, y1] = ind2sub(size(BOARD),move);
[x2, y2] = find(BOARD == TOPLAY);

x3 = x1 + (y2 - y1);
y3 = y1 - (x2 - x1);
x4 = x3 + (x2 - x1);
y4 = y3 + (y2 - y1);

% TODO: check if this covers all possible combinations with no duplicates
for i = 1:length(x2)
    if isvalid(x2(i), y2(i)) && ...
            isvalid(x3(i), y3(i)) && ...
            isvalid(x4(i), y4(i)) % x1, y1 are already valid
        SCORE(TOPLAY) = SCORE(TOPLAY) + (abs(x2(i)-x1) + abs(y2(i)-y1) + 1)^2;
    end
end

end

function out = isvalid(x, y)

global BOARD;
global TOPLAY;
[X_MAX, Y_MAX] = size(BOARD);

if x < 1 || x > X_MAX
    out = false;
elseif y < 1 || y > Y_MAX
    out = false;
elseif BOARD(x, y) ~= TOPLAY
    out = false;
else
    out = true;
end

end