clc

% Definerar givna variabler.
h = 0.1;
b = 1;
aL = 0; aR = 0; 
wL = 3; wR = 2;
x0 = 0;
y0 = 5/2; % Detta värde togs fram analytiskt.
theta0 = 0;

w = (wR - wL)/b;
tend = 2*pi / abs(w); % Tlap: tiden det tar att färdas ett varv.

% Definerar en anonym funktion för att kunna skicka med
% alla parametrar till fvel.
fvel_func = @(t, s) fvel(t, s, b, aL, aR, wL, wR);

% Beräknar en lösning med RK4 och Euler med h och h/10 som tidssteg.
[tv, sol_RK4] = RK4(fvel_func, h, [0, tend], [x0 y0 theta0]);
[~, sol_Euler1] = EulerF(fvel_func, h, [0, tend], [x0 y0 theta0]);
[~, sol_Euler2] = EulerF(fvel_func, h / 10, [0, tend], [x0 y0 theta0]);

% Plottar lösningarna
hold on
plot(sol_RK4(:,1), sol_RK4(:,2));
plot(sol_Euler1(:,1), sol_Euler1(:,2));
plot(sol_Euler2(:,1), sol_Euler2(:,2));
legend(["RK4" "Euler1" "Euler2"]);
axis equal