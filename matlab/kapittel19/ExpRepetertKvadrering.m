function [resultat] = ExpRepetertKvadrering(a,n)
% Regner ut a^n

resultat=1;
x=a;
while(n>0)
    if(mod(n,2)==1)
        resultat=resultat*x;
    end
    x=x*x;
    n=floor(n/2);
end

end

