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

B = (wR + wL)/2;
D = (wR - wL)/b;

% Definerar en anonym funktion för att kunna skicka med
% alla parametrar till fvel.
fvel_func = @(t,s) fvel(t, s, b, aL, aR ,wL, wR);

options = odeset('RelTol', 1e-8, 'AbsTol', 1e-8, "Refine", 1);
[tv, sol_ode45] = ode45(fvel_func, [0 tend], [x0 y0 theta0], options);

fprintf("Antal steg: %d \n", length(tv));

xana = @(tv) x0 + (B/D)*(sin(D*tv) - sin(theta0));
yana = @(tv) y0 - (B/D)*(cos(D*tv) - cos(theta0));

hold on

% Plottar felet mellan numeriska och analytiska lösningen.

xerr = abs(sol_ode45(:,1) - xana(tv));
yerr = abs(sol_ode45(:,2) - yana(tv));
plot(tv, xerr);
plot(tv, yerr);
legend(["x Error" "y Error"]);

% Plottar ODE45 lösning och analytisk lösning.
%{
plot(sol_ode45(:,1), sol_ode45(:,2));
plot(xana(tv), yana(tv));
legend(["ODE45" "Analytiska"]);
axis equal
%}
