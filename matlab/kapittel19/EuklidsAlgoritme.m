function [gcd] = EuklidsAlgoritme(a,b)
% Beregner største felles divisor mellom a og b

if(a<b)
    temp=b;
    b=a;
    a=temp;
end

while(b~=0)
    r=mod(a,b);
    a=b;
    b=r;
end

gcd=a;

end

