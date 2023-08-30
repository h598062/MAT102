% Her skal vi starte med grunnleggende MATLAB
% Vi kommenterer med %
% Definerer seksjoner med %%

%%
% Tilordne verdier 
a=4
b=6
a*b
c=a*b-5; 
c+2
c

%% 
% Fjerner innholdet i kommandovinduet
clc

a
b
%%
% Tømmer minne
clear all; 
format compact;
a
b
%%
% Oppretter en array med tall
I = [5 8 9 3 1];
I
% Arrays i MATLAB er indeksert fra 1 til 5
% Henter ut 1. og 3. verdi
I(1)
I(3)

%%
% Oppretter en heltallsarray fra 1 til 10
x = 1:10
% Oppretter en heltallsarray fra 10 til 20 med steglengde 3
x = 10:3:20
% Tilordne variabelen n verdien 30
n = 30
x = 1:n
% Opprette en nullarray
null(1:5) = 0

%%
% Litt matriseregning
M = [1 1 1; 2 2 2; 3 3 3] % Oppretter en 3x3-matrise
x = [1 2 3]
y= [1; 2; 3]

%%
% Oppgave: Prøv kommandoene M*x og M*y. Hva skjer her?


%%
% Arrayoperasjoner, elementvis
I = [1 3 2 4 5 2]   % Heltalsarray
J = 1:6             % [1 2 3 4 5 6]
K = 1:10

I+J                 % Adderer elementene i I og J
I+K                 % Feilmelding fordi I og K har ulik lengde 

I+10                % Adderer 10 til hvert element i I
I*2                 % Multipliserer hvert element i I med 2
I.*J                % Multipliserer elementene i I og J
I.*K                % Feilmelding fordi I og K har ulik lengde 
I./J                % Dividerer elementene i I og J
I./K
I.^2                % Hvert element opphøyes i 2. potens

M
x
M.*x
x.*M

%%
% Erstatte element i array

% Vil erstatte element 3 i x med tallet 7
x(3) = 7

N = M % Lager en matrise N lik M
% Vil erstatte posisjon 2,2 i matrise N med tallet 4
% og posisjon 2,3 med tallet 9
N(2,2) = 4
N(2,3) = 9

% For M og N er matrisemultiplikasjon definert. Studér forskjellen mellom
% operasjonene
M*N
M.*N

%%
% Vil legge til noen tall i slutten av x
x = [x 1 10 100]

% Vil legge til noen tall i starten av x
x = [0 0 0 x]

% Vil slette tredje element fra x
x(3) = []

% Vil slette 1. og 5. element fra x
x([1 5]) = []

%%
% Opprette chararray
char1 = ['h' 'e' 'i']
char2 = ['hei']
char3 = ['hai']

%%
% Sammenlikne disse
char1==char2 % elementvis
char1==char3 
strcmp(char1,char2) % hele stringen
strcmp(char1,char3)

%%
% Oppretter en chararray med bokstavene a til z
C = 'a':'z'

%%
% Grunnleggende regneoperasjoner for chararrays
C + 1  % Adderer hver bokstav i chararray C med 1

% MATLAB tolker dette som heltall

C+0
single('abcxyz')
char([97 98 99 120 121 122])

% I Matlab er 
    % a representert med heltallet 97
    % b representert med heltallet 98
    % ...
    % z representert med heltallet 122
% Viktig å huske for Cæsarkrypteringen!    

C+1
char(C+1)          % Det siste tegnet gir ikke mening i vår sammenheng

%%
% Søke og telle

% Telle antall elementer i en array
length(x)
numel(x)
length(M)
numel(M)

%%
% Hvor mange elementer i x er lik 1?
n1 = x==1 % Returnerer en logisk array n1 der verdien er 1 (sann) for elementene som er lik 1, og 0 (usann) for resten
f = find(x == 1)        % Returnerer indeksene til elementene i x som har verdien 1
n = numel(find(x==1))   % Antall element i I som har verdien 1
u = numel(find(char1=='a')) % Finner og teller bokstaven 'a' i char1

%%
% Telling i chararray
C = ['heheiheighthei']
m = count(C,'e')        % Teller antall e'er i chararray C
k = count(C,'he')       % Teller antall ganger  'he' dukker opp i C

%%
% help
help numel
help count

%%
% Oppgave: Definer en chararray bestående av navnet deres (kun små bokstaver).
% Hva er den tredje bokstaven i navnet deres?
% Hvor mange e-er og m-er er det i navnet?
% Hvilke plassering har disse?

%%
% Summere element i en array
n = sum(I)          % Summerer alle tallene i I
m = sum(I(2:4))     % Summerer elementene indeksert 2, 3 og 4
k = sum(I([1 2 6])) % Summerer tallene med indeks 1, 2 og 6

%%
% Modulus
r = mod(9,4)    % 9 modulus 4 er rest av 9 delt på 4. 9:4 er 2 med rest 1 (9=4*2+1).
R = mod(I,3)    % For hvert element i I, finner en I(i) modulus 3
