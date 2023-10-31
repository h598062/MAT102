% A-00, B-01, C-02, D-03, E-04, F-05, G-06, H-07, I-08, J-09, K-10
% L-11, M-12, N-13, O-14, P-15, Q-16, R-17, S-18, T-19, U-20, V-21, 
% W-22, X-23, Y-24, Z-25, mellomrom-99

%a) BAD WOLF

%b) 18151408 11041718


% Offentleg kodenøkkel:
n = 111094189;
e = 181;

%SPOILERS <-> 18151408 11041718
M1 = int64(18151408);
M2 = int64(11041718);
K1 = ExpModzRepetertKvadrering(M1,e,n); 
K2 = ExpModzRepetertKvadrering(M2,e,n);

%c)  K1 = 29596535
%    K2 = 106834039             
%     Kryptert = 29596535106834039  

% Primtal mindre enn sqrt(n)
P = Eratosthenes(sqrt(n));

%d) Finne primtala p og q slik at n=p*q
for i = 1:length(P)
    if(mod(n,P(i))==0)
        p=P(i);
        break;
    end
end
q=n/p;


%e)  n er produktet av to distinkte primtall pp og qq.
%    gcd(e,ϕ(n))=1
%    


EuklidsAlgoritmeRekursiv(n,e);
% Sjekket at gcd(e,ϕ(n))=1 og det dn erlik 1

%f) 
phi = (p-1)*(q-1);
d = InversModuloHeltall(e,phi);

% Dekrypteringsnøkkel er: d = 38660509 


% Dekrypterer fra oppgave c.

T1 = powerMod(K1,d,n);
T2 = powerMod(K2,d,n);  

% T1 =18151408      = SPOI
% T2 =11041718      = LERS


% 𝑈 = [45880674, 80479744, 72251437,66716738].

%g) 

U1 = int64(45880674);
U2 = int64(80479744);
U3 = int64(72251437);
U4 = int64(66716738);

L1 = powerMod(U1,d,n);
L2 = powerMod(U2,d,n);
L3 = powerMod(U3,d,n);
L4 = powerMod(U4,d,n);


% L1= 99050425    L2= 25041899    L3= 170499      L4= 2141411

% L1 = FEZ      L2= ZES     L3= ARE          COOL


% A-00, B-01, C-02, D-03, E-04, F-05, G-06, H-07, I-08, J-09, K-10
% L-11, M-12, N-13, O-14, P-15, Q-16, R-17, S-18, T-19, U-20, V-21, 
% W-22, X-23, Y-24, Z-25, mellomrom-99

% Ble ikke helt riktig dette eller kanskje det er det? Jeg vet ikke 
% hva en FEZ ZES er for noe men det er sikkert kult! Åjaaaa det er en
% Doctor who referanse
