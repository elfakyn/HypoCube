% AI player for the game.

function best_move = get_ai_move(difficulty)

global BOARD;
global SCORE; % we'll use this some day
global TOPLAY;
global SQUARES;

value = [0.01, 0.15, 0.75, 1.5];
offensive_bias = 1.01;
defensive_bias = 1;
selection_randomness = 0.0000001; % makes AI choose randomly between moves with equal value
weighed_randomness = max(0, 0.16 - 0.02 * difficulty);

best_move_value = -Inf;
best_move = 1; % This should always be overwritten the first chance
for move = 1:numel(BOARD)
    if ~BOARD(move) % spot not already occupied
        move_value = 0;
        for i = 1:size(SQUARES,1) % iterate through all squares
            toplay_occupied = 0; % number of spots in current square already occupied by toplay, including move
            opponent_occupied = 0;
            valid_contains_move = 0;
            for j = 1:4
                if BOARD(SQUARES(i,j)) == TOPLAY || SQUARES(i,j) == move
                    toplay_occupied = toplay_occupied + 1;
                end
                if BOARD(SQUARES(i,j)) == opponent(TOPLAY) || SQUARES(i,j) == move
                    opponent_occupied = opponent_occupied + 1;
                end
                if SQUARES(i,j) == move
                    valid_contains_move = 1;
                end
            end
            
            if ~valid_contains_move
                continue; % don't score squares that are unchanged by the move
            end
            
            if toplay_occupied && opponent_occupied <= 1 % opponent doesn't already block
                move_value = move_value + SQUARES(i,5) * ( ... % value gained by directly building squares
                    value(toplay_occupied) * offensive_bias ...
                    + randn * weighed_randomness); 
            end
            if opponent_occupied && toplay_occupied <= 1 % we don't already block
                move_value = move_value + SQUARES(i,5) * ( ... % value gained by blocking opponent from building squares
                    value(opponent_occupied) * defensive_bias ...
                    + randn * weighed_randomness); 
            end
        end
        if move_value + randn * selection_randomness > best_move_value
            best_move = move;
            best_move_value = move_value + randn * selection_randomness;
        end
    end
end
            