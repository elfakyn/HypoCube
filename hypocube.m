function hypocube(varargin)

if nargin ~= 2
    against_ai = 1;
    difficulty = 4;
else
    against_ai = varargin{1};
    difficulty = varargin{2};
end

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

% Pregenerate the array of squares if it doesn't exist already
if ~exist(sprintf('pregenerated_squares/squares_%d_%d.csv', size(BOARD,1), size(BOARD, 2)),'file')
    if ~exist('pregenerated_squares','dir') % Always good to check for the folder too
        mkdir('pregenerated_squares');
    end
    generate_squares(size(BOARD,1), size(BOARD,2));
end

global SQUARES;
SQUARES = csvread(sprintf('pregenerated_squares/squares_%d_%d.csv', size(BOARD,1), size(BOARD, 2)));

gui = struct;

gui.bsize = size(BOARD);
gui.boxdim = [40, 40]; % please keep this square or the GUI will have weird bugs.
gui.boxgap = [0, 0];
gui.topmargin = 2*gui.boxdim(2);
gui.margins = 0.5 * gui.boxdim;
gui.images = {imread('assets/board_slot.png'), imread('assets/blue_ball.png'), imread('assets/orange_ball.png')};
gui.color_index_table = [94, 162, 255; 255, 196, 94];

global OVERLAY;
OVERLAY = zeros(gui.bsize(1) * gui.boxdim(1), gui.bsize(2) * gui.boxdim(2));

gui.width = gui.bsize(1)*gui.boxdim(1) + 2*gui.margins(1) - gui.boxgap(1);
gui.height = gui.bsize(2)*gui.boxdim(2) + 2*gui.margins(2) + gui.topmargin;

% Main GUI
gui.main = figure('Name', 'HypoCube' ...
    , 'NumberTitle', 'off' ...
    , 'Position', [100, 150, gui.width, gui.height] ...
    );

% Score display
gui.scoreboard = uicontrol(gui.main ...
    , 'Style', 'text' ...
    , 'Position', [gui.margins(1), gui.height - gui.topmargin/2 - 10, gui.width - 2*gui.margins(1), 30] ...
    , 'FontSize', 8 ...
    , 'String', sprintf('Game not started\nGo ahead!') ...
    );

% Play against AI checkbox
gui.against_ai = uicontrol(gui.main ...
    , 'Style', 'checkbox' ...
    , 'Position', [gui.margins(1), gui.height - gui.topmargin/2 - 35, 100, 20] ...
    , 'String', 'Play against AI' ...
    , 'FontSize', 8 ...
    , 'Value', against_ai ...
    );

% Difficulty dropdown
gui.difficulty = uicontrol(gui.main ...
    , 'Style', 'popupmenu' ...
    , 'Position', [gui.margins(1) + 110, gui.height - gui.topmargin/2 - 34, 100, 20] ...
    , 'TooltipString', 'Difficulty' ...
    , 'FontSize', 8 ...
    , 'String', 'Novice|Average|Experienced|Skilled|Adept|Masterful|Inhuman|Godlike' ...
    , 'Value', difficulty ...
    );

% New game button
gui.new_game = uicontrol(gui.main ...
    , 'Style', 'pushbutton' ...
    , 'Position', [gui.width - 100 - gui.margins(1), gui.height - gui.topmargin/2 - 35, 100, 20] ...
    , 'FontSize', 8 ...
    , 'String', 'New game' ...
    );

% Board
for i = 1:gui.bsize(1)
    for j = 1:gui.bsize(2)
        gui.board(i, j) = uicontrol(gui.main ...
            , 'Style', 'pushbutton' ...
            , 'Position', [gui.margins(1)+(i-1)*gui.boxdim(1), gui.margins(2)+(j-1)*gui.boxdim(2), gui.boxdim(1)-gui.boxgap(1), gui.boxdim(2)-gui.boxgap(2)] ...
            , 'CData', gui.images{1} ...
            , 'FontSize', 8 ...
            );
    end
end

% Callbacks

set(gui.new_game ...
    , 'Callback', @(hObject, eventdata) hypocube(is_against_ai(gui.against_ai), get_difficulty(gui.difficulty)) ...
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

end

function against_ai = is_against_ai(gui_against_ai)

against_ai = get(gui_against_ai, 'Value');

end

function difficulty = get_difficulty(gui_difficulty)

difficulty = get(gui_difficulty, 'Value');

end