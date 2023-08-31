%% Rensk arbeidsplassen...

clc;
clear all;
format compact;

%% Kode basert på skriptet brukt for eksempel 14.1.5, fokus på Poissonfordeling. 

% I vårt pensum har vi tre teljevariablar, og Poissonfordelinga er ei av
% desse. (Dei to andre er binomiske fordeling, og hypergeometrisk
% fordeling.)

% Dersom vi har ein situasjon der vi tel noko i løpet av eit tidsintervall
% av lengde t, og vi har at (1) det vi tel skjer med ein konstant
% intensitet, (2) at talet hendingar i disjunkte (ikkje-overlappande)
% tidsintervall er uavhengige, og (3) at vi ikkje har at to av dei tinga vi
% tel vil skje nøyaktig samtidig, så har vi ei Poissonfordeling.  I ein
% slik situasjon må vi kjenne til lengda t av tidsintervallet og
% intensiteten (som regel gitt ved gresk bokstav lambda). 

% I MATLAB kan vi rekne ut sannsynet for ulike sannsyn relatert til ei
% Poissonfordeling via 'poisspdf'-funksjonen, men ettersom de ikkje har
% tilgang til MATLAB på eksamen vil vi her bruke formelen for punktsannsyn
% direkte.

%% Spesifisering av parametrane til vår Poissonfordeling.

lambda = .5;
t = 4;

% Merk: Poissonfordelinga er ein teljevariabel, og verdimengda startar på
% 0.  Men merk at det i utgangspunktet ikkje er ei avgrensing på kor mange
% observasjonar vi kan ha av det vi held på å telje...  (For dei som synest
% det høyrest litt rart ut, så hugs at dette er ein modell, og det er ikkje
% slik at den faktiske verden som vi skal ut og telje i er lik modellen. Vi
% er fornøgde når modellen gir ei grei tilnærming til det vi ser på. For
% dei som har hatt fysikk, tenk på det at vi der som regel ignorerer
% luftmotstand. Med mindre vi er i eit vakum vil det vere ein luftmotstand,
% men i mange praktiske utrekningar gjer det ikkje så mykje om vi ser vekk
% frå denne detaljen. Så lenge vi får eit "godt nok svar" er alt OK.)

% Når vi skal lage ein figur er det naturlegvis nødvendig å ha ei øvre
% grense på kor langt vi vil lage plottet...
maks_verdi = max(10, ceil(4 * lambda * t));

Verdimengde_X = 0:maks_verdi;

% Rekn ut dei tilhøyrande punktsannsyna.

clear Prob_X
Prob_X(1:length(Verdimengde_X)) = 0;
for x = Verdimengde_X
    Prob_X(x+1) =  (lambda * t)^x/factorial(x) * exp(-lambda*t);
end
% MERK: Utrekning via denne formelen fungerer dårleg når x vert stor, både
% potensen med 'x' og 'factorial(x)' kan då rote ting til. I slike tilfelle
% bør koden under brukast. NB: Krev at MATLAB har ein av tilleggspakkane,
% så om du får feilmelding må du installere det som manglar. HUGS: 100 er
% her ei øvre grense i plottet fordi formelen for utrekning av punktsannsyn
% inneheld 'factorial'.

% Prob_X = poisspdf(lambda*t, Verdimengde_X);

% Enkel visualisering 
bar(Verdimengde_X, Prob_X)
%% Finn forventingsverdi

%.. Merk: Vi kan rekne ut forventingsverdien som før, dvs. via,
% E_X = sum(Verdimengde_X .* Prob_X)
%.. men på eksamensdagen må vi bruke formelen

E_X = lambda * t

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

Var_X = lambda * t

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