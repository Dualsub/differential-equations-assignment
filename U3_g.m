clc
format long;

% Definerar givna variabler.
x0 = 0;
y0 = 5/2; % Detta värde togs fram analytiskt.
theta0 = 0;
tend = 5*pi / 8;
h = tend / 100;

% Beräknar det analytiska värdet vid t=tend.
xana = x0 + (((wR + wL)/2)  / ((wR - wL)/b))*sin(((wR - wL)/b) * tend);

% Definerar en anonym funktion för att kunna skicka med
% alla parametrar till fvel.
fvel_func = @(t,s) fvel(t, s, b, aL, aR ,wL, wR);

xsol = zeros(3); % Kolumner representerar metoder och rader är olika värden på dt.

for i=1:3 % 2^(i-1) där i-1 är 0,1,2, ger 1,2,4.
    dt = h/2^(i-1);
    [tv, sol_RK4] = RK4(fvel_func, dt, [0, tend], [x0 y0 theta0]);
    [~, sol_Euler1] = EulerF(fvel_func, dt, [0, tend], [x0 y0 theta0]);
    [~, sol_Euler2] = EulerF(fvel_func, dt / 100, [0, tend], [x0 y0 theta0]);
    xsol(i,:) = [abs(sol_RK4(end, 1)-xana) abs(sol_Euler1(end, 1)-xana) abs(sol_Euler2(end, 1)-xana)];
end

% Beräknar noggrannhetsordning
pRK4 = log(xsol(1,1) / xsol(2,1))/log(2);
pE1 = log(xsol(1,2) / xsol(2,2))/log(2);
pE2 = log(xsol(1,3) / xsol(2,3))/log(2);

fprintf("pRK4: %d \npE1: %d \npE2: %d\n", pRK4, pE1, pE2);
fprintf("X solution:\n");
disp(xsol);

% Plottar XY för samtliga lösningar
hold on
plot(sol_RK4(:,1), sol_RK4(:,2));
plot(sol_Euler1(:,1), sol_Euler1(:,2));
plot(sol_Euler2(:,1), sol_Euler2(:,2));
legend(["RK4" "Euler1" "Euler2"]);
axis equal