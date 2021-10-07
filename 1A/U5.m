clc

b = 1;

%a.)
%aL = 2; aR = 2; wL = 4; wR = 1;

%b.)
%aL = 1; aR = 3; wL = 2; wR = 4;

%c.)
aL = 2; aR = 1; wL = 1; wR = 5;

tend = 10;
h = 0.1;
x0 = 0;
y0 = 5/2; % Värde som tagits fram analystiskt.
theta0 = 0;

% Definerar de analystiska funktionerna.
B = (wR + wL)/2;
D = (wR - wL)/b;
xana = @(tv) x0 + (B/D)*sin(D*tv);
yana = @(tv) y0 - (B/D)*(cos(D*tv) - 1);

% Definerar en anonym funktion för att kunna skicka med
% alla parametrar till fvel.
fvel_func = @(t,s) fvel(t, s, b, aL, aR ,wL, wR);


options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8, "Refine", 4);
[tv, sol_ode45] = ode45(fvel_func, [0 tend], [x0 y0 theta0], options);

fprintf("Antal steg: %d \n", length(tv));

hold on;

% Plotta XY färdbana.

plot(sol_ode45(:,1), sol_ode45(:,2));
scatter(x0, y0, "g");
scatter(sol_ode45(end,1), sol_ode45(end,2), "r");
legend(["ODE45" "Start", "End"]);


% Plotta Plotta XY mot tiden.
%{
plot(tv, sol_ode45(:,1:2));
legend(["X" "Y"]);
%}

% Plotta felet i XY.
%{
xerr = abs(sol_ode45(:,1) - xana(tv));
yerr = abs(sol_ode45(:,2) - yana(tv));

plot(tv, xerr);
plot(tv, yerr);
legend(["x Error" "y Error"]);
axis equal
%}