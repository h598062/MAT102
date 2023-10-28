function [M] = powerMod(N,e,m)
% powerMod regner M = N^e mod m
% uten aa bruke stoerre tall i mellomregningen enn m^2
% For RSA: Kall powerMod(klartekst, e, n) for kryptering
% powerMod(kryptert, d, n) for dekryptering
if N ==0
    M=0;
elseif e==1
    M = mod(N,m);
else
    M = 0;
    if (mod(e,2)==0) % e even
        M = powerMod(N, e/2,m);
        M = mod(M*M,m);
    else % e odd
        M = mod(N,m);
        M = mod(M*powerMod(N,e-1,m),m);
    end
end
end

