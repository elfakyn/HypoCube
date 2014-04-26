function play_move(move, gui)

global BOARD;
global TOPLAY;
global SCORE;

% Update button corresponding to move
set(gui.board(sub2ind(gui.bsize, move)) ...
    , 'Enable', 'off' ...
    , 'String', TOPLAY ...
    );

BOARD(move) = TOPLAY;

SCORE = SCORE + move_score(move, TOPLAY);

set(gui.scoreboard ...
    , 'String', sprintf('Player 1: %d\nPlayer 2: %d', SCORE(1), SCORE(2)) ...
    );

end_game_if_over(gui);
change_player();