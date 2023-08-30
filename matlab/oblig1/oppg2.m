%% Oppgave 2

clear all; 
format compact;

% øyne / sannsynlighet
%	1		2		3	4		5		6
%	0.25	0.05	a	0.15	0.25	0.2

%% a

P = [0.25, 0.05, 0.15, 0.25, 0.2];

P3 = 1 - sum(P) % 0.1
% oppdater liste med sannsynligheter
P = [P(1:2), P3, P(3:end)]
%% b

% E1: tallet er partall
% E2: tallet er 3 eller 6
% E3: tallet er >= 4

% summer sannsynlighetene for hver gyldige mulighet
PE1 = sum(P(2:2:end))	% 0.4
PE2 = P(3) + P(6)		% 0.3
PE3 = sum(P(4:end))		% 0.6

%% c

% alle unike muligheter fra E2 og E3
PE2uE3 = sum(P(3:end))	% 0.7
% når både E2 og E3 er oppfyllt
PE2nE3 = P(6)			% 0.2

%% d

% sannsynlighet for at den er 3 eller 6 (E2)
% når det allerede er gitt at den er >= 4 (E3)

% bruker formel P = PE2nE3 / PE3
PE2lE3 = PE2nE3 / PE3	% 0.3333