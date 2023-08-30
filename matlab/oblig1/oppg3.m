%% Oppgave 3

clear all;
format compact;

%% a

% Poisson-fordeling?

% det er 30 oppkoblinger gjennomsnitt per min
% Y = antall oppkoblinger på 10 sek

lambda = 30/60*10; % Gjennomsnittlig antall oppkoblinger på 10 sekunder
tilkoblinger = 3:30; % Antall tilkoblinger fra 3 til 30

% lager en tom liste for å holde sannsynligheter som regnes ut
sannsynligheter = zeros(size(tilkoblinger));

for i = 1:length(tilkoblinger)
	y = tilkoblinger(i);
	sannsynligheter(i) = exp(-lambda) * (lambda^y) / factorial(y);
end

% Sum sannsynlighetene for 3 eller flere tilkoblinger
Y = sum(sannsynligheter)

%% b

% binomisk fordeling?

% parametre n: antall bits, p: sjanse for feil i overføring av bit

pskade = 8 * 0.02 % 0.16

%% c



