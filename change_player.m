function change_player()

global TOPLAY;

if TOPLAY == 1
    TOPLAY = 2;
elseif TOPLAY == 2
    TOPLAY = 1;
else
    error('TOPLAY is neither 1 nor 2. This should never happen.');
end