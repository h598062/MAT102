% for-løkker og if-setninger i MATLAB

% Syntaks for-løkker:
%    
% for i = startverdi:steglengde:stoppverdi
%   HANDLING
% end

%%
clear all           
clc                 
format compact     

%%
% For-løkke for heltall mellom 1 og 10
for i = 1:10
    i
end

%%
% For-løkke for heltall mellom 10 og 1
for i = 5:-1:1
    i
end

%%
% For-løkke med steglengde 2
for i = 1:2:10
    i
end

%%
% For-løkke for bokstaver
for i = 'a':2:'z'
    i
end

%%
% Fibonacci-rekken
% 1 1 2 3 5 8 13 21...
I = [1 1]
for i = 3:15
    I(i) = sum(I([(i-2) (i-1)]))
end

%%
I = [1 3 4 6 9]
for i = 1:length(I)
    j = sum(I([(1:i)]))
    J(i) = sum(I([(1:i)]))
end
% Legger dere merke til forskjellen mellom j og J?
j
J

%%
I = [2 6 1 5];
for i = 1:numel(I)
    disp(I(i))
end

% for each
% Løkken nedenfor gjør det samme
for i = I
    disp(i)
end

%%
% Syntaks if-setning
%if expression
%    statements
%elseif expression
%    statements
%else
%    statements
%end

% Tell hvor mange 0-ere og 1-ere som er i arrayen
I = [1 1 0 0 0 1 0 1 1 0 1 1 1 0]
n = 0
m = 0
for i = I
    if i==1
        n = n+1;
    else
        m = m+1;
    end
end    
n
m

%%
% Oppgave: Finn det største tallet i en array ved å bruke for-løkke

% MATLAB har en innebygd funksjon max(I), men her skal dere lage funksjonen
% selv