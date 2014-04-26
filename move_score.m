function score = move_score(move, toplay)

global BOARD;
score = [0, 0];

[x1, y1] = ind2sub(size(BOARD),move);
[x2, y2] = find(BOARD == toplay);

x3 = x1 + (y2 - y1);
y3 = y1 - (x2 - x1);
x4 = x3 + (x2 - x1);
y4 = y3 + (y2 - y1);

% TODO: check if this covers all possible combinations with no duplicates
for i = 1:length(x2)
    if isvalid(x2(i), y2(i), toplay) ...
            && isvalid(x3(i), y3(i), toplay) ...
            && isvalid(x4(i), y4(i), toplay) ... % x1, y1 are already valid
            && ~(x1 == x2(i) && y1 == y2(i))
        score(toplay) = score(toplay) + (abs(x2(i)-x1) + abs(y2(i)-y1) + 1)^2;
    end
end

end

function out = isvalid(x, y, toplay)

global BOARD;

if x < 1 || x > size(BOARD,1)
    out = false;
elseif y < 1 || y > size(BOARD,2)
    out = false;
elseif BOARD(x, y) ~= toplay;
    out = false;
else
    out = true;
end

end