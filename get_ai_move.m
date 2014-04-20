% AI player for the game. Horribly inefficient.

function best_move = get_ai_move(depth)

global SCORE;
global TOPLAY;

best_move = negamax(TOPLAY, SCORE, depth, []); % The existence of the fourth parameter says that it's the toplevel negamax call.

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Negamax algorithm used to determine best play;
function value = negamax(toplay, score, depth, varargin)

if depth == 0
    value = value_asymmetrical(toplay, score); % In a true minimax algorithm the value should not be asymmetrical.
                                               % This might have to be fixed.
    return;
end

global BOARD;

max_value = -2;

for move = 1:64 % try all moves
    if ~BOARD(move)
        BOARD(move) = toplay; % do move
    else
        continue; % skip evaluation if spot is occupied
    end
    
    winner = game_over(score);
    
    if winner == toplay
        value = 1;
    elseif winner == 3-toplay % opponent
        value = -1;
    elseif winner == -1 % board full, no winners
        value = 0;
    else
        value = -negamax(3 - toplay, score + move_score(move,toplay), depth - 1);
    end
    BOARD(move) = 0; % undo move
    
    if value > max_value
        max_value = value;
        if (nargin == 4)
            the_move = move;
        end
    end
end

if (nargin == 4)
    value = the_move; % This is ugly and I deserve to be whipped once for every time this gets evaluated.
                      % That would be once per AI call.
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evaluates the value of a board configuration to a player

function value = value_asymmetrical(toplay, score)

% Yes I know this is duplicate code.
winner = game_over(score);
if winner == toplay
    value = 1;
    return;
elseif winner == 3-toplay % opponent
    value = -1;
    return;
elseif winner == -1
    value = 0;
    return;
end

global WINNING_SCORE;

value = (2*score(toplay) - score(3-toplay)) / (2*WINNING_SCORE); % TODO: optimize this

end