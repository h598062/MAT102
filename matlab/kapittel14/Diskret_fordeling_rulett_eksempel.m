%% Rensk arbeidsplassen...

clc;
clear all;
format compact;

%% Litt kode basert på eksempel 14.1.5

Verdimengde_X = [0 10 15 25]

% Nedanfor, justert for tapt innsats. Regelen er at du får igjen det doble
% av insatsen dersom du vinn veddemålet.  Ettersom det er to veddemål har
% vi dermed fleire ulike alternativ å ta stilling til. Verdimengda nedanfor
% er gitt ved 2 * [0 10 15 25] - 25.

% Verdimengde_X = [-25, -5, 5, 25]

Prob_X = [11 9 9 9] / 38

% Enkel visualisering 
bar(Verdimengde_X, Prob_X)
%% Finn forventingsverdi

E_X = sum(Verdimengde_X .* Prob_X)

% Visualisering med forventingsverdi (som stipla linje i raud farge)

bar(Verdimengde_X, Prob_X)
hold on
plot([E_X, E_X], [0, max(Prob_X)], 'Color', "red", ...
     'LineWidth', 3, 'LineStyle', '-.')
hold off
%% Utrekning av varians, via formel Var(X) = E(X^2) - E(X)^2

E_X2 = sum(Verdimengde_X .^2 .* Prob_X)

Var_X = E_X2 - E_X^2

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

n = 50;
sample = randsample(Verdimengde_X, n, true, Prob_X);

%  Estimer forventing, varians og standardavvik frå utvalet vårt.

estimert_E_X = mean(sample)
estimert_Var_X = var(sample)
estimert_SD_X = sqrt(estimert_Var_X)

% Finn estimerte også estimerte verdiar av Prob_X basert på utvalet.

estimert_Prob_X = zeros(size(Verdimengde_X));
for i = 1:length(Verdimengde_X)
    estimert_Prob_X(i) = sum(sample == Verdimengde_X(i)) / n ;
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
