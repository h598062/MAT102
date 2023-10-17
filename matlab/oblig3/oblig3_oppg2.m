% Bruker PCA scriptet fra Canvas som base

% Dette scriptet finner de a første prinsipalkomponentane til en 
% datamatrise X. Fra scriptet finner vi:
    % T = scores-matrisen (koordinatene til prinsipalkomponentene)
    % P = loading-matrisen (prinsipalkomponentene til X)
    % Grafisk framstilling av prinsipalkomponentene
    % Forklart variasjon av prinsipalkomponentene
    
clear all

% Laster inn datamatrisen
% X1, X2				- Datamatrisene
% objNames1, objNames2	- navn på objektene
% varNames1, varNames2	- navn på variablene
load('Arbeidskrav3.mat')

pcaAnalyse(X1, objNames1, varNames1)
pcaAnalyse(X2, objNames2, varNames2)

% wrappet kode i funksjon for å lett kjøre to ganger
function pcaAnalyse(X, objnavn, varnavn) 

	% Antall prinsipalkomponenter vi ønsker å finne i X-matrisen
	a = 2; % oppg c, Rekn ut dei to første prinsipalkomponentane
	% Error/toleransenivå
	error = 0.00001
	
	% Først preprosesserer vi matrisen slik at hver kolonne får gjennomsnitt 0
	% og standardavvik 1
	[n,m] = size(X);    % n = antall objekt (land)
                    	% m = antall variabler (matvarer)
	meanX = mean(X);    % Gjennomsnittet til hver kolonne i X-matrisen
	stdX = std(X);      % Standardavviket til hver kolonne i X-matrisen
	for j = 1:m
    	X(:,j) = X(:,j) - meanX(j); % Trekker fra gjennomsnittet i kolonne j 
                              	
    	if stdX(j)~=0
        	X(:,j)= X(:,j)/stdX(j); % Dividerer kolonne j med standardavviket 
                                	% til kolonne j
                                	% NB! Skal ikke gjøres om standardavviket
                                	% er 0
    	end
	end
	Xstand = X;                      % Preprosessert/standardisert matrise
	
	% Bruker NIPALS-metoden for å finne de a største egenvektorene til 
	% transponert(X)X (prinsipalkomponentene til X).
	% Nonlinear iterative partial least squares
	% NIPALS-algoritmen er beskrevet i kompendiet på s.333.
	% Likner power-metoden for å beregne egenvektorer
	% NIPALS-algoritmen brukes for å finne egenvektorene for store datasett
	
	
	% Initialiserer scores/loadingmatrisen som 0-matriser.
	T = zeros(n,a); 
	P = zeros(m,a);
	
	for i=1:a
    	t_old = rand(n,1); % Oppretter en tilfeldig vektor (kan være en kolonnevektor av X)
    	p = Xstand'*t_old; % Projiserer den standardiserte matrisen på t_old for å finne loading-vektoren
    	p = p/norm(p); % Normaliserer p til lengde 1.
    	t = Xstand*p; % Projiserer den standardiserte matrisen på p for å finne scores-vektoren
    	while (norm(t-t_old)>error) % Fortsetter dersom avstanden er større enn en forhåndsbestemt toleranseverdi
        	p = Xstand'*t;
        	p = p/norm(p);
        	t_old = t;
        	t = Xstand*p;
    	end
    	T(:,i) = t;     % Scores
    	P(:,i) = p;     % Loading
    	Xstand = Xstand - t*p';
	end
	
	% Finner forklart variasjon av de a første prinsipalkoeffisientene.
	trX = trace(X'*X);      % Trace av standardisert matrise X
	trT = trace(T'*T);      % Trace av scores-matrisen
	fprintf('Forklart variasjon med %d prinsipalkomponenter er: %4.2f\n',a,trT/trX*100)
	
	% Plotter scores-matrisen (de to første prinsipalkomponentene).
	figure('Name', 'Scores P1P2')
	scatter(T(:,1), T(:,2))
	text(T(:,1)+.1, T(:,2),objnavn)
	hold on
	plot(0,0,'or')  % Tegner inn origo (som referanse)
	grid on
	
	% Plotter loading-matrisa.
	figure('Name', 'Loading P1P2')
	scatter(P(:,1), P(:,2))
	text(P(:,1)+.01, P(:,2),varnavn)
	hold on
	plot(0,0,'or')  % Tegner inn origo (som referanse)
	grid on
	
	return 
	
	% Hvis en finner de 3 første prinsipalkomponentene:
	
	% Plotter de 3 første prinsipalkomponentene i et 3d-koordinatsystem
	figure
	scatter3(T(:,1), T(:,2),T(:,3))
	text(T(:,1)+0.1, T(:,2), T(:,3),objnavn)
	hold on
	plot3(0,0,0,'or')  % Tegner inn origo (som referanse)
	grid on
	
	% Loading
	figure
	scatter3(P(:,1), P(:,2),P(:,3))
	text(P(:,1)+0.01, P(:,2), P(:,3),varnavn)
	hold on
	plot3(0,0,0,'or')  % Tegner inn origo (som referanse)
	grid on
	
	% Plotter 1. og 3. prinsipalkomponent
	figure
	scatter(T(:,1), T(:,3))
	text(T(:,1)+.1, T(:,3),objnavn)
	hold on
	plot(0,0,'or')  % Tegner inn origo (som referanse)
	grid on
	% Plotter loading-matrisen.
	figure
	scatter(P(:,1), P(:,3))
	text(P(:,1)+.01, P(:,3),varnavn)
	hold on
	plot(0,0,'or')  % Tegner inn origo (som referanse)
	grid on
	
	% Plotter 2. og 3. prinsipalkomponent
	figure
	scatter(T(:,2), T(:,3))
	text(T(:,2)+.1, T(:,3),objnavn)
	hold on
	plot(0,0,'or')  % Tegner inn origo (som referanse)
	grid on
	% Plotter loading-matrisa.
	figure
	scatter(P(:,2), P(:,3))
	text(P(:,2)+.01, P(:,3),varnavn)
	hold on
	plot(0,0,'or')  % Tegner inn origo (som referanse)
	grid on

end