%% Rensk arbeidsplassen...

clc;
clear all;
format compact;

%% Kode basert på skriptet brukt for eksempel 14.1.5, fokus på hypergeometrisk fordeling. 

% I vårt pensum har vi tre teljevariablar, og den hypergeometriske
% fordelinga er ei av desse. (Dei to andre er binomiske fordeling, og
% Poissonfordeling.)

% Dersom vi har ein situasjon der vi (1) tel enten-eller utfall, og (2) der
% vi ikkje har tilbakelegging (tenk t.d. på å trekke 5 kort frå ein
% kortstokk, og vi vil sjå kor mange spar som vi har trekt ut), så har vi
% ei hypergeometrisk fordeling.  I ein slik situasjon har vi eit tal N som
% gir oss samla tal element (kort) vi har tilgang til (N=52 kort), og vi
% har eit tal M som seier oss kor mange kort som er i den gruppa vi er
% interessert i (M=13 spar), i tillegg har vi eit tal n som seier oss kor
% mange element vi ser på (n=5 i dette tilfellet).  

% I MATLAB kan vi rekne ut sannsynet for ulike sannsyn relatert til ei
% hypergeometrisk fordeling via 'hygepdf'-funksjonen, men ettersom de ikkje
% har tilgang til MATLAB på eksamen vil vi her bruke formelen for
% punktsannsyn direkte.  For denne utrekninga vil vi ha bruk for utrekning
% av binomialkoeffisientar, og dette kan vi i MATLAB gjere via
% 'nchoosek'-funksjonen (på ein enkel kalkulator vil de finne ein
% 'nPr'-knapp som gjer same jobben).

%% Spesifisering av parametrane til vår hypergeometriske fordeling.

N = 52;
M = 13;
n = 13;

% NB: Talet M gir oss ei maksgrense på kor mange vi kan sjå som
% tilfredstiller kravet vi ser på. Vidare: Dersom vi trekk mange nok kort,
% så vil det også vere ei nedre grense for kor mange kort vi minst må få
% ut.

maks_verdi = min(n,M);
min_verdi = max(0, M - (N-n));

Verdimengde_X = min_verdi:maks_verdi;

% Rekn ut dei tilhøyrande punktsannsyna.

clear Prob_X
Prob_X(1:length(Verdimengde_X)) = 0;
for x = Verdimengde_X
    Prob_X(x+1-min_verdi) =   nchoosek(M,x)*nchoosek(N-M,n-x) / nchoosek(N,n);
end    

% Enkel visualisering 
bar(Verdimengde_X, Prob_X)
%% Finn forventingsverdi

%.. Merk: Vi kan rekne ut forventingsverdien som før, dvs. via,
% E_X = sum(Verdimengde_X .* Prob_X)
%.. men på eksamensdagen må vi bruke formelen

E_X = n * M /N

% Visualisering med forventingsverdi (som stipla linje i raud farge)

bar(Verdimengde_X, Prob_X)
hold on
plot([E_X, E_X], [0, max(Prob_X)], 'Color', "red", ...
     'LineWidth', 3, 'LineStyle', '-.')
hold off
%% Utrekning av varians

%.. Merk: Vi kan rekne ut forventingsverdien som før, dvs. via formel
%.. Var(X) = E(X^2) - E(X)^2, dvs.  
% E_X = sum(Verdimengde_X .* Prob_X)
% E_X2 = sum(Verdimengde_X .^2 .* Prob_X)
% Var_X = E_X2 - E_X^2
%.. men på eksamensdagen må vi bruke formelen

Var_X = n*(M/N) * (1 - M/N) * (N-n)/(N-1)

% Finn standardavviket ved å ta kvadratrot. (SD frå engelsk Standard
% deviation.)

SD_X = sqrt(Var_X)

% Visualisering med forventingsverdi, og pluss/minus eitt standardavvik
bar(Verdimengde_X, Prob_X)
hold on
plot([E_X, E_X], [0, max(Prob_X)], 'Color', "red", ...
     'LineWidth', 3, 'LineStyle', '-.')
plot([E_X, E_X] - SD_X, [0, max(Prob_X)], 'Color', "magenta", ...
     'LineWidth', 2, 'LineStyle', '-.')
plot([E_X, E_X] + SD_X, [0, max(Prob_X)], 'Color', "magenta", ...
     'LineWidth', 2, 'LineStyle', '-.')
hold off
%% Vi vil trekke frå fordelinga

n_sample = 30;
sample = randsample(Verdimengde_X, n_sample, true, Prob_X);

%  Estimer forventing, varians og standardavvik frå utvalet vårt.

estimert_E_X = mean(sample)
estimert_Var_X = var(sample)
estimert_SD_X = sqrt(estimert_Var_X)

% Finn estimerte også estimerte verdiar av Prob_X basert på utvalet.

estimert_Prob_X = zeros(size(Verdimengde_X));
for i = 1:length(Verdimengde_X)
    estimert_Prob_X(i) = sum(sample == Verdimengde_X(i)) / n_sample ;
end

% Vis plott med både original fordeling og resultat basert på utval.

% Visualisering med forventingsverdi, og pluss/minus eitt standardavvik

figure;
% Øverste plott (sann fordeling)
subplot(2, 1, 1); % 2 rader, 1 søyle, første plott
bar(Verdimengde_X, Prob_X)
hold on
plot([E_X, E_X], [0, max(Prob_X)], 'Color', "red", ...
     'LineWidth', 3, 'LineStyle', '-.')
plot([E_X, E_X] - SD_X, [0, max(Prob_X)], 'Color', "magenta", ...
     'LineWidth', 2, 'LineStyle', '-.')
plot([E_X, E_X] + SD_X, [0, max(Prob_X)], 'Color', "magenta", ...
     'LineWidth', 2, 'LineStyle', '-.')
hold off
% Nederste plott (basert på utval)
subplot(2, 1, 2);
bar(Verdimengde_X, estimert_Prob_X)
hold on
plot([estimert_E_X, estimert_E_X], [0, max(estimert_Prob_X)], 'Color', "red", ...
     'LineWidth', 3, 'LineStyle', '-.')
plot([estimert_E_X, estimert_E_X] - estimert_SD_X, [0, max(estimert_Prob_X)], 'Color', "magenta", ...
     'LineWidth', 2, 'LineStyle', '-.')
plot([estimert_E_X, estimert_E_X] + estimert_SD_X, [0, max(estimert_Prob_X)], 'Color', "magenta", ...
     'LineWidth', 2, 'LineStyle', '-.')
hold off

%% OBS: Det er ikkje sikkert at alle verdiane er observert i vårt sample!

% Det kan vere at vi ikkje ser sjeldne hendingar når vi trekk frå ei
% binomisk fordeling.  Dette kan vi undersøke ved t.d. å sjå på:

unique(sample)

format shortG
[Prob_X; estimert_Prob_X    ]
format default