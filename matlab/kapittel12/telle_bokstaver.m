% Beregner den empiriske sannsynligheten (relative frekvensen) av bokstavene i det engelske alfabetet fra en gitt tekst. 
clear all          
clc               
format compact   

%%
% Oppretter en chararray "tekst" som inneholder referanseteksten
% Leser fil og fjerner tegn som ikke er bokstaver.

fil = 'romeo_juliet.txt';      % Relativt filnavn til teksten som skal analyseres
tekst = fileread(fil);  % Leser fil
tekst(~(isletter(tekst)))=[]; % Fjerner innhold som ikke er bokstaver

% MATLAB skiller mellom små og store bokstaver, og vi ønsker ikke å skille
% mellom det her
tekst = lower(tekst);   % Omgjør alle bokstavene til små bokstaver

%%
% Oppretter en array for å telle forekomsten av hver bokstav
% Denne må ha 26 elementer, hvor første element svarer til forekomst for "a", 
% andre "b",..., og 26. element svarer til "z"
I(1:26)=0;  

%%
% Bruker for-løkke for å telle hver bokstav
% Husk at i MATLAB er 'a'=97 og 'z'=122.
% Forskyver med -96 for at 'a' skal få indeks 1, b indeks 2, osv.
for c='a':'z'   
    I(c-96)=count(tekst,c);
end

%%
% Beregner den relative frekvensen med formelen f/n, hvor f er den
% observerte frekvensen og n det totale antallet bokstaver i teksten
%
n = sum(I); % Summerer I
P=I/n;      % Relativ frekvens 
            % P(1) = sannsynlighet for 'a', P(2) = sannsynlighet for 'b', ... 
bar(P)      % Grafisk framstilling
