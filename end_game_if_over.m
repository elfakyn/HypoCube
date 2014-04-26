function end_game_if_over(gui)

global SCORE;
winner = is_game_over(SCORE);

if winner == 0
    return;
end

if winner == 1 || winner == 2
    set(gui.scoreboard ...
        , 'String', sprintf('Player %d wins with %d points\nand a lead of %d points.', winner, SCORE(winner), abs(SCORE(1)-SCORE(2))) ...
        );
elseif winner == -1
    set(gui.scoreboard ...
        , 'String', sprintf('Board is full.\nThere are no winners.') ...
        );
else
    error('No winners but no tie either. This should never happen');
end

for i = 1:gui.bsize(1)
    for j = 1:gui.bsize(2)
        set(gui.board(i,j), 'Enable', 'off') % disable entire board
    end
end