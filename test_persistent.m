%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%      DO NOT COMMIT!!!!!!      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tests whether persistent variables work in subroutines

function test_persistent()

persistent FOO;

if isempty(FOO)
    FOO = 100;
end

subroutine()

disp(FOO);

end

function subroutine()

persistent FOO;

if isempty(FOO)
    FOO = 1;
else
    FOO = 2;
end

end