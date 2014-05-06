function play_move(move, gui)

global BOARD;
global TOPLAY;
global SCORE;
global LAST_MOVE;

% Delete label on the last move.
if ~isempty(LAST_MOVE)
    set(gui.board(sub2ind(gui.bsize, LAST_MOVE)) ...
        , 'String', '' ...
        );
end
% Update button corresponding to move
set(gui.board(sub2ind(gui.bsize, move)) ...
    , 'Enable', 'inactive' ...
    , 'String', '#' ...
    , 'CData', gui.ball{TOPLAY} ...
    );

LAST_MOVE = move;
BOARD(move) = TOPLAY;

SCORE = SCORE + move_score(move, TOPLAY);

set(gui.scoreboard ...
    , 'String', sprintf('Player 1 (blue): %d\nPlayer 2 (orange): %d', SCORE(1), SCORE(2)) ...
    );

end_game_if_over(gui);

TOPLAY = opponent(TOPLAY); % change player