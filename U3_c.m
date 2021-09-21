clc

% Definerar givna variabler.
h = 0.1;
b = 1;
aL = 0; aR = 0; 
wL = 3; wR = 2;
x0 = 0; y0 = 0; theta0 = 0;

w = (wR - wL)/b;
tend = 10;

% Definerar en anonym funktion för att kunna skicka med
% alla parametrar till fvel.
fvel_func = @(t, s) fvel(t, s, b, aL, aR, wL, wR);

% EulerF är definerad i en separat fil.
% Beräknar en lösning med EulerF med h som tidssteg.
[tv, sol] = EulerF(fvel_func, h, [0, tend], [x0 y0 theta0]);

% Plottar lösningarna.
hold on
plot(tv, sol(:,1));
plot(tv, sol(:,2));
legend(["X" "Y"]);