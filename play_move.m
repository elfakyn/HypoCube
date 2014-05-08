function play_move(move, gui)

global BOARD;
global TOPLAY;
global SCORE;
global LAST_MOVE;
global SQUARES;
global OVERLAY;

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
    );  

LAST_MOVE = move;
BOARD(move) = TOPLAY;

SCORE = SCORE + move_score(move, TOPLAY);

% Recalculate overlay
line = zeros(2,2);
for i = 1:size(SQUARES,1)
    if valid_square_conquered(i, move, TOPLAY)
        for j = 1:4
            [line(1,1), line(1,2)] = ind2sub(gui.bsize, SQUARES(i,j));
            [line(2,1), line(2,2)] = ind2sub(gui.bsize, SQUARES(i,1+mod(j,4)));
            
            line(:,1) = line(:,1) .* gui.boxdim(1) - gui.boxdim(1)/2 - 1 + TOPLAY; % x
            line(:,2) = line(:,2) .* gui.boxdim(2) - gui.boxdim(2)/2 - 1 + TOPLAY; % y
            
            OVERLAY = image_overlay_add_line(OVERLAY, line, TOPLAY);
        end
    end
end

% Update overlay
for i = 1:gui.bsize(1)
    for j = 1:gui.bsize(2)
        set(gui.board(i,j) ...
            , 'CData', image_burn_overlay(gui.images{BOARD(i,j) + 1}, OVERLAY, [1+(i-1)*gui.boxdim(1), 1+(j-1)*gui.boxdim(2)], gui.boxdim, gui.color_index_table) ...
            );
    end
end

% Update scoreboard
set(gui.scoreboard ...
    , 'String', sprintf('Player 1 (blue): %d\nPlayer 2 (orange): %d', SCORE(1), SCORE(2)) ...
    );

end_game_if_over(gui);

TOPLAY = opponent(TOPLAY); % change player