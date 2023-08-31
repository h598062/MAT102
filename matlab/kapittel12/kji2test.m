% Kjikvadrattest for relative frekvenser av bokstavene i en referansetekst 
% og en Caesarkryptert tekst kryptert med ukjent kodenøkkel k. 
% Målet er å finne kodenøkkel k

clear all           % Tømme minne
clc                 % Fjerne innhold i workspace
format compact      % Kompakt utskrift i workspace


%%
% Oppretter en chararray "tekst" som inneholder referanseteksten
% Leser fil og fjerner tegn som ikke er bokstaver.

fil = 'romeo_juliet.txt';      % Relativt filnavn til teksten som skal analyseres
tekst = fileread(fil);  % Leser fil
tekst = lower(tekst);   % Omgjør alle bokstavene til små bokstaver
tekst(~(isletter(tekst)))=[];

%%
% Gjentar for den krypterte teksten
fil_kryptert = 'bokkryptert.txt';       % Relativt filnavn til kryptert tekst
kryptert = fileread(fil_kryptert);       
kryptert = lower(kryptert);    
kryptert(~(isletter(kryptert)))=[];

%%
% Oppretter arrays for å telle forekomsten av hver bokstav
R(1:26) = 0;
O(1:26) = 0;
       
%%
% Bruker for-løkke for å telle hver bokstav
% Husk at i MATLAB er 'a'=97 og 'z'=122.
% Forskyver med -96 for at 'a' skal få indeks 1, b indeks 2, osv.
for c='a':'z'   
    R(c-96)=count(tekst,c);
    O(c-96)=count(kryptert,c);
end

%%
% Beregner den relative frekvensen i referanseteksten med formelen f/n, hvor f er den
% observerte frekvensen og n det totale antallet bokstaver i teksten
%
n = sum(R);
R=R/n;
            
% Gjentar for den krypterte teksten
m = sum(O); 
O=O/m; 
      
%%
% Kjikvadrattest mellom referansetabell R og observert tabell O rotert j-plasser tilbake.
C(1:26) = 0;

for j=1:26
    C(j)=sum((R-circshift(O,-j)).^2./R); % NB! Husk at vi regner med arrays
end

% Undersøk cirkshift
% A = [1 2 3 4 5]
%circshift(A,-1)
%circshift(A,-2)

bar(C)

%%
% Finner kodenøkkel
[minimum,k] = min(C)  
% NB! k=26 tilsvarer k=0 i forelesningsnotatene
%%
% Dekrypterer
dekryptert = char(mod(kryptert-97-k,26)+97)

% Lagrer den dekrypterte teksten i en fil
fid = fopen('bokdekryptert.txt','w');
fprintf(fid,dekryptert);
fclose(fid);

clear all 

%%
% Oppgave:
% Bruk kjikvadrattesten til å finne kodenøkkelen for
% 'nbcmcmupylsmywlynnyrn' og dekrypter deretter teksten.
% Hva er det som går galt?
% Prøv igjen med referanseteksten bok2.txt