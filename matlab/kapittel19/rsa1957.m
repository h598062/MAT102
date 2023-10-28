% A-00, B-01, C-02, D-03, E-04, F-05, G-06, H-07, I-08, J-09, K-10
% L-11, M-12, N-13, O-14, P-15, Q-16, R-17, S-18, T-19, U-20, V-21, 
% W-22, X-23, Y-24, Z-25, mellomrom-99

% Offentleg kodenøkkel:
n = 111094189;
e = 181;

%a: DEAD <-> 03040003 <-> 3040003
M = int64(3040003);
K = ExpModzRepetertKvadrering(M,e,n);

% K = 33398349

%b: Primtal mindre enn sqrt(n)
P = Eratosthenes(sqrt(n));

%c: Finne primtala p og q slik at n=p*q
for i = 1:length(P)
    if(mod(n,P(i))==0)
        p=P(i);
        break;
    end
end
q=n/p;

%d: 
phi = (p-1)*(q-1);
d = InversModuloHeltall(e,phi);

% Dekrypteringsnøkkel er: d = 27883597

%e: 
% Dekrypterer svaret i a.
ExpModzRepetertKvadrering(K,d,n);

% Vi fekk tilbake den opprinnelege koda 3040003 <-> 03040003
