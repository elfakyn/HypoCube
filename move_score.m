function score = move_score(move, toplay)

global BOARD;
global SQUARES;
score = [0, 0];

for i = 1:size(SQUARES,1)
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
        score(toplay) = score(toplay) + SQUARES(i,5);
    end
end