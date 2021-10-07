clc

% Definerar givna variabler.
b = 1;
aL = 0; aR = 0; 
wL = 3; wR = 2;
x0 = 0; 
y0 = 5/2; % Detta värde togs fram analytiskt.
theta0 = 0;

w = (wR - wL)/b;
tend = 2*pi / abs(w); % Tlap: tiden det tar att färdas ett varv.
h = tend / 100;

% Definerar en anonym funktion för att kunna skicka med
% alla parametrar till fvel.
fvel_func = @(t, s) fvel(t, s, b, aL, aR, wL, wR);

% EulerF är definerad i en separat fil.
% Beräknar en lösning med EulerF med h som tidssteg.
[tv, sol] = EulerF(fvel_func, h, [0, tend], [x0 y0 theta0]);

% Plottar lösningarna.
hold on
plot(sol(:,1), sol(:,2));
scatter(0, 0, "g");
legend(["Lösning" "Mittpunkt"]);
axis equal