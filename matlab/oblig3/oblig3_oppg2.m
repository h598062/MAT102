clear all

% Variabler hentet inn fra fil
% X1 - datamatrisen
% objNames1
% varNames1
load('Arbeidskrav3.mat');
disp('X1:')
disp(X1);
disp('');
disp('objNames1:')
disp(objNames1);
disp('');
disp('varNames1:')
disp(varNames1);
disp('');
disp('End print')

% Oppg a
% preprosessering slik at kolonner får gjennomsnitt 0 og stda 1
[n,m] = size(X1); % n er antall rader, m er antall kolonner i X1 matrisen
disp(X1);
avgX1 = mean(X1) % regn ut gjennomsnitt i X1
stdaX1 = std(X1) % regn ut standardavvik i X1

avgFixX1 = bsxfun(@minus, X1, avgX1)
stdaAvgFixX1 = bsxfun(@rdivide, avgFixX1, stdaX1)

pcaX1 = pca(stdaAvgFixX1)