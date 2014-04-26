function run_game_cycle(hObject,eventdata,gui)

global SCORE;

% move is position of button that was just pushed
% This routine should never fail.
for i = 1:gui.bsize(1)
    for j = 1:gui.bsize(2)
        if gui.board(i, j) == hObject
            move = sub2ind(gui.bsize, i, j);
        end
    end
end

play_move(move, gui);

if get(gui.against_ai, 'Value') && ~is_game_over(SCORE)
    pause(0.5) % make it seem that the AI is doing something
    move = get_ai_move(1);
    play_move(move, gui);
end