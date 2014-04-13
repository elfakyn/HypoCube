function move = get_human_move()

global BOARD;
global TOPLAY;

[X_MAX, Y_MAX] = size(BOARD);

fprintf('Player %d to go.\n', TOPLAY);

% Input validation: must place inside board, cannot place on occupied spot.
ok = false;
while ~ok
    x = input('x: ');
    y = input('y: ');
    
    if x < 1 || x > X_MAX
        disp('X value out of bounds');
    elseif y < 1 || y > Y_MAX
        disp('Y value out of bounds');
    elseif BOARD(x, y)
        disp('Cannot place on an already occupied spot')
    else
        ok = true;
    end
end

move = sub2ind(size(BOARD),x,y);