% Initialize global variables;
% This is probably not best practice but it'll do for now.
global BOARD;
global SCORE;
global TOPLAY;

BOARD = zeros(8); % Board size is hardcoded. Neat, eh?
SCORE = [0 0];
TOPLAY = 1;

while ~game_over()
    move = get_human_move();
    recalculate_score(move); % recalculate_score assumes move has not been played yet
    play_move(move);
    disp_current_state();
    change_player();
end

winner = game_over();

if winner == 1
    disp('First player wins!');
elseif winner == 2
    disp('Second player wins!');
elseif winner == -1
    disp('Tie');
else
    error('Nobody wins but it''s not a tie either. This should never happen.');
end