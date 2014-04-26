function hypocube()

% clc;
% clear all;
clear global;
close all;

% Initialize global variables;
global BOARD;
global SCORE;
global TOPLAY;

BOARD = zeros(8); % Board size is hardcoded. Neat, eh?
SCORE = [0, 0];
TOPLAY = 1;

gui = struct;

gui.bsize = size(BOARD);
gui.boxdim = [40, 40];
gui.boxgap = [0, 0];
gui.topmargin = gui.boxdim(2);
gui.margins = 0.5 * gui.boxdim;
gui.ball{1} = imread('assets/blue_ball.png');
gui.ball{2} = imread('assets/orange_ball.png');
gui.background = imread('assets/board_slot.png');

gui.width = gui.bsize(1)*gui.boxdim(1) + 2*gui.margins(1) - gui.boxgap(1);
gui.height = gui.bsize(2)*gui.boxdim(2) + 2*gui.margins(2) + gui.topmargin;

% Main GUI
gui.main = figure('Name', 'HypoCube' ...
    , 'NumberTitle', 'off' ...
    , 'Position', [200, 300, gui.width, gui.height] ...
    );

% Play against AI checkbox
gui.against_ai = uicontrol(gui.main ...
    , 'Style', 'checkbox' ...
    , 'Position', [gui.width - 100 - gui.margins(1), gui.height - gui.topmargin/2 - 15, 100, 15] ...
    , 'String', 'Play against AI' ...
    , 'Value', 0 ...
    );

% New game button
gui.new_game = uicontrol(gui.main ...
    , 'Style', 'pushbutton' ...
    , 'Position', [gui.width - 100 - gui.margins(1), gui.height - gui.topmargin/2 - 30, 100, 15] ...
    , 'String', 'New game' ...
    );

% Score display
gui.scoreboard = uicontrol(gui.main ...
    , 'Style', 'text' ...
    , 'Position', [gui.margins(1), gui.height - gui.topmargin/2 - 30, 200, 30] ...
    , 'String', sprintf('Game not started\nGo ahead!') ...
    );

% Board
for i = 1:gui.bsize(1)
    for j = 1:gui.bsize(2)
        gui.board(i, j) = uicontrol(gui.main ...
            , 'Style', 'pushbutton' ...
            , 'Position', [gui.margins(1)+(i-1)*gui.boxdim(1), gui.margins(2)+(j-1)*gui.boxdim(2), gui.boxdim(1)-gui.boxgap(1), gui.boxdim(2)-gui.boxgap(2)] ...
            , 'CData', gui.background ...
            );
    end
end

% Callbacks
set(gui.new_game ...
    , 'Callback', @(hObject, eventdata)hypocube() ...
    );

% So... for some reason, I have to put this in a separate for. If I put
% this where I create the board pushbuttons, I get index out of bounds when
% I search for position of button that was just pushed in run_game_cycle.
% This warrants more investigation.
for i = 1:gui.bsize(1)
    for j = 1:gui.bsize(2)
        set(gui.board(i, j) ...
            , 'Callback', {'run_game_cycle',gui} ...
            , 'Interruptible', 'off' ...
            , 'BusyAction', 'cancel' ...
            );
    end
end
