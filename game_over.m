function winner = game_over()

% Game is over when the board is full or when one player has at least
% WINNING_SCORE points with a lead of at least WIN_THRESHOLD

WINNING_SCORE = 150;
WIN_THRESHOLD = 15; % Keep this positive or funky things will happen.

global SCORE;
global BOARD;

% TODO: check if this covers all use cases
if SCORE(1) >= WINNING_SCORE && SCORE(1) - SCORE(2) >= WIN_THRESHOLD
    winner = 1;
elseif SCORE(2) >= WINNING_SCORE && SCORE(2) - SCORE(1) >= WIN_THRESHOLD
    winner = 2;
elseif all(BOARD) % board is full
    winner = -1; % no winners
else
    winner = 0; % game not over
end