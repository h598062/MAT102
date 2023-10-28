% A-00, B-01, C-02, D-03, E-04, F-05, G-06, H-07, I-08, J-09, K-10
% L-11, M-12, N-13, O-14, P-15, Q-16, R-17, S-18, T-19, U-20, V-21, 
% W-22, X-23, Y-24, Z-25, mellomrom-99

% Offentleg kodenøkkel:
n = 111094189;
e = 181;

% a)
%    [1000399,22141105]
% 01 00 03 99,22 14 11 05
%  B  A  D     W  O  L  F

% b)
%  S  P  O  I   L  E  R  S
% 18 15 14 08,11 04 17 18
%   [18151408,11041718]

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


