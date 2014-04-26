function play_move(move, gui)

global BOARD;
global TOPLAY;
global SCORE;

% Update button corresponding to move
set(gui.board(sub2ind(gui.bsize, move)) ...
    , 'Enable', 'inactive' ...
    ..., 'String', TOPLAY ...
    , 'CData', gui.ball{TOPLAY} ...
    );

BOARD(move) = TOPLAY;

SCORE = SCORE + move_score(move, TOPLAY);

set(gui.scoreboard ...
    , 'String', sprintf('Player 1 (blue): %d\nPlayer 2 (orange): %d', SCORE(1), SCORE(2)) ...
    );

end_game_if_over(gui);
change_player();