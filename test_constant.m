%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%      DO NOT COMMIT!!!!!!      %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bs = 8;
total = 0;
for i = 0:bs/2
    for j = 0:bs/2
        if (i > j)
            k = j;
        else
            k = i;
        end
        
        k = bs/2-k;
        
        for n=0:bs-k*2+1
            for m = 0:bs-k*2+1
                total = total+1;
            end
        end
    end
end

for i = 0:bs/2
    for j = 0:bs/2
        if ~((i==bs/2-1) && (j==bs/2-1))
            if i > j
                k = i;
            else
                k = j;
            end
            
            if i > j
                k = j;
            else
                k = i;
            end
            
            k = bs/2-k;
            
            for n=0:bs-k*2+2
                for m=0:bs-k*2+2
                    total = total+1;
                end
            end
        end
    end
end

disp(total);