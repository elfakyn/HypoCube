function winner = game_over(score)

% Game is over when the board is full or when one player has at least
% WINNING_SCORE points with a lead of at least WIN_THRESHOLD

global WINNING_SCORE;
global WIN_THRESHOLD;

WINNING_SCORE = 150;
WIN_THRESHOLD = 15; % Keep this positive or funky things will happen.

global BOARD;

% TODO: check if this covers all use cases
if score(1) >= WINNING_SCORE && score(1) - score(2) >= WIN_THRESHOLD
    winner = 1;
elseif score(2) >= WINNING_SCORE && score(2) - score(1) >= WIN_THRESHOLD
    winner = 2;
elseif all(BOARD) % board is full
    winner = -1; % no winners
else
    winner = 0; % game not over
end