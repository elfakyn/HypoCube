function score = move_score(move, toplay)

global SQUARES;
score = [0, 0];

for i = 1:size(SQUARES,1)
    if valid_square_conquered(i, move, toplay)
        score(toplay) = score(toplay) + SQUARES(i,5);
    end
end