%% Rensk arbeidsplassen...

clc;
clear all;
format compact;

%% Kode basert på skriptet brukt for eksempel 14.1.5, fokus på binomisk fordeling. 

% I vårt pensum har vi tre teljevariablar, og den binomiske fordelinga er
% ei av desse. (Dei to andre er hypergeometrisk fordeling, og
% Poissonfordeling.)

% Dersom vi har ein situasjon der vi (1) tel enten-eller utfall, (2) der vi
% har same sannsyn for "suksess" kvar gang, og (3) der dei ulike utfalla er
% uavhengige av kvarandre (tenk t.d. på ein sekvens av 10 terningkast, der
% vi for kvart kast vil sjå om teringen viser ein seksar), så har vi ei
% binomisk fordeling.  I ein slik situasjon må vi finne ut kor mange utfall
% vi ser på (n=10 i terningkast-eksempelet), og kva som er sannsynet for
% den hendinga vi tel (p=1/6 for terningkast-eksempelet).  

% MERK: "suksess" vert ofte nytta for "det at vi ser det vi held på å
% telje", og det vert gjort uavhengig av om det er noko som vi normalt
% ville ha sett på som positivt eller negativt. Så dersom vi tel talet
% studentar som står på eksamen, så er "suksess" det at ein student har
% fått ein ståkarakter -- men dersom vi tel talet studentar som stryk på
% eksamen, så er "suksess" det at studenten ikkje står på eksamen...

% I MATLAB kan vi rekne ut sannsynet for ulike sannsyn relatert til ei
% binomisk fordeling via 'binopdf'-funksjonen, men ettersom de ikkje har
% tilgang til MATLAB på eksamen vil vi her bruke formelen for punktsannsyn
% direkte.  For denne utrekninga vil vi ha bruk for utrekning av
% binomialkoeffisientar, og dette kan vi i MATLAB gjere via
% 'nchoosek'-funksjonen (på ein enkel kalkulator vil de finne ein
% 'nPr'-knapp som gjer same jobben).

%% Spesifisering av parametrane til vår binomiske fordeling.

n = 10;
p = 1/6;

Verdimengde_X = 0:n;

% Rekn ut dei tilhøyrande punktsannsyna.

clear Prob_X
Prob_X(1:(n+1)) = 0;
for x = Verdimengde_X
    Prob_X(x+1) = nchoosek(n,x) * p^x * (1-p)^(n-x);
end    

% Enkel visualisering 
bar(Verdimengde_X, Prob_X)
%% Finn forventingsverdi

%.. Merk: Vi kan rekne ut forventingsverdien som før, dvs. via,
% E_X = sum(Verdimengde_X .* Prob_X)
%.. men på eksamensdagen må vi bruke formelen

E_X = n*p

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

Var_X = n*p*(1-p)

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