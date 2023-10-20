clear all
close all

% Laster inn datamatrisen fra Arbeidskrav3.mat
load('Arbeidskrav3.mat')
X = X1; % Bruker datamålinger som slutter med 1
names = objNames1;
varnames = varNames1;

% Antall prinsipalkomponenter vi ønsker å finne i X-matrisen
a = 2; % Vi vil bare ha de to første prinsipalkomponentene

% Error/toleransenivå
error = 0.00001;

% Preprosesserer X-matrisen slik at hver kolonne har gjennomsnitt 0 
% og standardavvik 1
[n, m] = size(X);
meanX = mean(X);
stdX = std(X);
for j = 1:m
    X(:,j) = X(:,j) - meanX(j);
    if stdX(j) ~= 0
        X(:,j) = X(:,j) / stdX(j);
    end
end
Xstand = X;

% b) Forklaring på preprosessering:
% Preprosesseringen gjøres for at målenhetetene skal være like.
% I mange datassett kan variablene måles i ulike enheter. For eksempel
% kan noe måles i gram og noe annet i centimeter. Ved å skalere får vi like
% vekt til alle variabelen i analysen. Dette gjør at
% hver variabel bidrar likt til PCA-analysen, uavhengig av måleenhet eller 
% størrelsesorden.Uten denne normaliseringen kan variabler med store verdier 
% dominere resultatene, noe som kan være misledende


% Bruker NIPALS-metoden for å finne prinsipalkomponentene til X
T = zeros(n, a);
P = zeros(m, a);
for i = 1:a
    t_old = rand(n, 1);
    p = Xstand' * t_old;
    p = p / norm(p);
    t = Xstand * p;

    while (norm(t-t_old) > error)
        p = Xstand' * t;
        p = p / norm(p);
        t_old = t;
        t = Xstand * p;
    end

    T(:,i) = t;
    P(:,i) = p;
    Xstand = Xstand - t * p';
end

% Viser forklart variasjon
trX = trace(X' * X);
trT = trace(T' * T);
fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f%%\n', a, trT/trX*100);

% Plotter scores-matrisen
figure('Name', 'Scores P1P2');
scatter(T(:,1), T(:,2));
text(T(:,1)+.1, T(:,2), names);
hold on;
plot(0, 0, 'or');
grid on;

% Plotter loadings-matrisen
figure('Name', 'Loading P1P2');
scatter(P(:,1), P(:,2));
text(P(:,1)+.01, P(:,2), varnames);
hold on;
plot(0, 0, 'or');
grid on;

% d) 
% Basert på posisjonen til disse punktene kan vi observere at de er 
% relativt nær hverandre i dette todimensjonale rommet. 
% Dette indikerer at de to forsøkene med "innstilling 5" er ganske like i
% henhold til de to hovedkomponentene som er representert på x- og y-aksene.
% Konklusjonen, basert på figuren er at smakspanelet på "insttiling 5" er 
% relativ like ettersom punktene ikke er spredt langt fra hverandre.

% e)
% Forklart variasjon med 2 prinsipalkomponenter er: 98.36%

% f) "O1:Milk+" har en høy score for både PC1 og PC2, plassert i øvre høyre
% hjørne av plottet.
