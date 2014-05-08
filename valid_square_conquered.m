function ok = valid_square_conquered(i, move, toplay)

ok = 0;

global BOARD;
global SQUARES;

valid_contains_move = 0;
valid_all_same_player = 1;

for j = 1:4
    if SQUARES(i,j) == move
        valid_contains_move = 1;
    end
    if BOARD(SQUARES(i,j)) ~= toplay
        valid_all_same_player = 0;
    end
end

if valid_contains_move && valid_all_same_player
    ok = 1;
end