function [s] = InversModuloHeltall(a,b)
% Beregner den inverse av a modulo b dersom dette finnes

[gcd, sp, tp]=EuklidsAlgoritmeRekursivST(a,b);

s=mod(sp,b);
t=mod(tp,b);

if(mod(a*s,b)==1)
    s=s;
else
    s=t;
end

end

