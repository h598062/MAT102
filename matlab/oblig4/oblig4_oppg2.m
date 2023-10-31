% A-00, B-01, C-02, D-03, E-04, F-05, G-06, H-07, I-08, J-09, K-10
% L-11, M-12, N-13, O-14, P-15, Q-16, R-17, S-18, T-19, U-20, V-21, 
% W-22, X-23, Y-24, Z-25, mellomrom-99
clear all;
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
spoiler = [int64(18151408), int64(11041718)];
spoilerKryptert = zeros(1, length(spoiler));

for i = 1:length(spoiler)
    result = ExpModzRepetertKvadrering(spoiler(i), e, n);
    spoilerKryptert(i) = int64(result);
end
disp("SPOILER:")
disp(spoiler);
disp("Kryptert:");
disp(spoilerKryptert);
% C)
% 29596535 106834039

% D)
U = [45880674, 80479744, 72251437,66716738];

P = Eratosthenes(sqrt(n));

for i = 1:length(P)
    if(mod(n,P(i))==0)
        p=P(i);
        break;
    end
end
q=n/p;
disp("p:")
disp(p); 
disp("q:")
disp(q);
% p: 7937
% q: 13997

% E)
phi = (p-1)*(q-1);
esvar = EuklidsAlgoritmeRekursivST(e,phi);
disp("Korrekt om denne blir 1:");
disp(esvar); % 1
% n må være et produkt av to store primtall (p og q)
% e må være relativt primtall med phi(n)
% dette sjekker vi med å regne ut phi og bruke euklids algoritme
% hvis den blir 1, så er det gyldig krypteringsnøkkel

% F)
d = InversModuloHeltall(e, phi);
disp("Dekrypteringsnøkkel:");
disp(d); % 38660509

C1 = powerMod(int64(spoilerKryptert(1)), d, n);
C2 = powerMod(int64(spoilerKryptert(2)), d, n);
disp("dekryptert C");
disp(C1); % 18151408
disp(C2); % 11041718

% G)

T = zeros(1, length(U));
for i = 1:length(U)
    result = powerMod(int64(U(i)), d, n);
    T(i) = int64(result);
end
disp("U dekryptert:");
disp(T);
% nr 3 mangler et tall, leading 0 blir fjernet, skal være en A fremst
% 99050425 25041899 00170499 02141411
% [ FEZ] [ZES ] [ARE ] [COOL]

% doctor who referanse

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


