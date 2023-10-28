function [gcd, s, t] = EuklidsAlgoritmeRekursivST(a,b)
% Beregner største felles divisor mellom a og b rekursivt

if(a<b)
    aminst=1;
    temp=b;
    b=a;
    a=temp;
else
    aminst=0;
end

if(b==0)
    s=1;
    t=0;
    gcd=a;
else
    q=floor(a/b);
    r=mod(a,b);
    [gcd, sp, tp]=EuklidsAlgoritmeRekursivST(b,r);
    s=tp;
    t=sp-tp*q;
end

if (aminst==1)
    temp=s;
    s=t;
    t=temp;
end

end

