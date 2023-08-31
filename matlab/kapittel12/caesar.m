% Caesarkryptering

clear all           % Tømmer minne
clc                 % Fjerne innhold i kommandovindu
format compact      % Kompakt utskrift

% Tekst som skal krypteres
klartekst = 'dennetekstenkanleses';

% Kodenøkkel k.
k = 25;

% Kryptering av klartekst
% Generell formel: 𝑓(𝑛)=𝑛+𝑘 mod 𝑁
% a=97, b=98,..., z=122
% I MATLAB: 𝑓(𝑛)=(𝑛+𝑘−97)mod 26+97

kryptert = char(mod(klartekst-97+k,26)+97)

%kryptert = 'xcy'

% Dekryptering
% Generell formel: g(𝑛)=𝑛-𝑘 mod 𝑁
% I MATLAB: 𝑔(𝑛)=(𝑛−𝑘−97)mod 26+97.

dekryptert = char(mod(kryptert-97-k,26)+97)

% Hvis kodenøkkel er ukjent, kan en bruke for-løkke for å lete gjennom de
% 26 mulighetene

for k=0:25
    dekryptert = char(mod(kryptert-97-k,26)+97)     
end

% Kan legge alle muligheter inn i en stringarray
for k=0:25
    D(k+1) = string(char(mod(kryptert-97-k,26)+97))     
end
