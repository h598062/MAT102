function [resultat] = ExpModzRepetertKvadrering(a,n,z)
% Regner ut a^n mod z
	a=int64(a);
	resultat=1;
	x=mod(a,z);
	while(n>0)
    	if(mod(n,2)==1)
        	resultat=mod(resultat*x,z);
    	end
    	x=mod(x*x,z);
    	n=floor(n/2);
	end
end