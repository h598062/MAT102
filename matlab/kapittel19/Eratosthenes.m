function [PrimeList] = Eratosthenes(n)
% Eratosthenes regner ut primtallene under n

PrimeList = 1:n;
PrimeList(1) = 0; % 0 will indicate not a prime
for i = 2:sqrt(n)
    if PrimeList(i)~=0
        j = i;
        while (j*i<=n)
            PrimeList(j*i)=0;
            j = j+1;
        end
    end
end
PrimeList = PrimeList(PrimeList~=0);
end

