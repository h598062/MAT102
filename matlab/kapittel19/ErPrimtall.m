function [test] = ErPrimtall(n)
% Sjekker om n er primtall for n>=2

test='primtall';
for i = 2:floor(sqrt(n))
    if(mod(n,i)==0)
        test='ikke primtall';
    end

end

