function [gcd] = EuklidsAlgoritmeRekursiv(a,b)
% Beregner største felles divisor mellom a og b rekursivt

if(a<b)
    temp=b;
    b=a;
    a=temp;
end

if(b==0)
    gcd=a;
else
    r=mod(a,b);
    gcd=EuklidsAlgoritmeRekursiv(b,r);
end

end

