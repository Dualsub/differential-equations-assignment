clc

% Definerar givna variabler.
b = 1; 
aL = 0; aR = 0;
wL = 3; wR = 2;
x0 = 0;
y0 = 5/2; % Detta värde togs fram analytiskt.
theta0 = 0;

tend = 5*pi / 8;
h = tend / 100;

% Beräknar det analytiska värdet av x vid t=tend.
xana = x0 + (((wR + wL)/2)  / ((wR - wL)/b))*sin(((wR - wL)/b) * tend);

% Definerar en anonym funktion för att kunna skicka med
% alla parametrar till fvel.
fvel_func = @(t,s) fvel(t, s, b, aL, aR ,wL, wR);

% Beräknar numeriska lösningar.
[tv, sol_RK4] = RK4(fvel_func, h, [0, tend], [x0 y0 theta0]);
[~, sol_Euler1] = EulerF(fvel_func, h, [0, tend], [x0 y0 theta0]);
[~, sol_Euler2] = EulerF(fvel_func, h / 10, [0, tend], [x0 y0 theta0]);

% Plottar lösningar.
hold on
plot(sol_RK4(:,1), sol_RK4(:,2));
plot(sol_Euler1(:,1), sol_Euler1(:,2));
plot(sol_Euler2(:,1), sol_Euler2(:,2));
legend(["RK4" "Euler1" "Euler2"]);
axis equal

% Beräknar felen vid slutiden.
RK4err = abs(sol_RK4(end,1) - xana);
euler1err = abs(sol_Euler1(end,1) - xana);
euler2err = abs(sol_Euler2(end,1) - xana);
fprintf("RK4 Error: %d \n", RK4err);
fprintf("Euler 1 Error: %d \n", euler1err);
fprintf("Euler 2 Error: %d \n", euler2err);
