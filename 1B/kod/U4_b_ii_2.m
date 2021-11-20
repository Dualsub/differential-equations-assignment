% Givna systemparametrar.
m1 = 460; m2 = 60;
k1_ref = 5500; k2_ref = 130000;
k1 = k1_ref; k2 = 100*k2_ref;
c1 = 300; c2 = 1300;
v  = (60/3.6);
H = 0.2;
L = 1;

% Systemmatrisen
A = [0, 0, 1, 0; 
    0, 0, 0, 1; 
    -k1/m1, k1/m1, -c1/m1, c1/m1; 
    k1/m2, -(k1 + k2)/m2, c1/m2, -(c1 + c2)/m2
    ];

% Initialvilkor
v_0 = [0;0;0;0];

% Anonym funktion som retunerar g(t) för ett t.
% Gör så att inte samtliga parametrar måste skickas med manuellt vid varje anrop.
gfunc = @(t) G(H,L,v,k2,c2,m2,t);

% Functionen för ODE45
vfunc = @(t, y) quartercar(t,y,A,k2,c2,m2,H,L,v);

% Beräknar t_max
F = @(lambda) -2*real(lambda) / abs(lambda)^2;

eigs = eig(A);
dts = zeros(length(eigs), 1);
for i=1:length(eigs)
   dts(i) = F(eigs(i));
end

t_0 = 10^-5;

% Beräknar tidsvektor
tend = 0.05;
h = (1/8) * t_0; % Först för det minsta värdet på alpha
N = floor(tend/h);
tv = h*(0:N); % Beräknar alla tider i tidsspannet.

% Beräknar referenslösning med ODE45.
opts = odeset('RelTol', 1e-9, 'AbsTol', 1e-9);
[tvref, yref] = ode45(vfunc, tv, v_0, opts);

pvec = zeros(1, 4);
for n=0:3
    tvn = tv(1:2^n:end);
    [~, solm] = ITM(A, tvn, gfunc, v_0);
    errv = solm(2,:)' - yref(1:2^n:end,2); % 2^n ger hur många steg som ska tas i tidsvektorn. 
    err = max(abs(errv));
    pvec(4 - n) = err; % Fyller backlänges.
end

% Beräknar noggrannhetsordning
pe10 = log(pvec(1) / pvec(2))/log(2);
pe20 = log(pvec(2) / pvec(3))/log(2);
pe40 = log(pvec(3) / pvec(4))/log(2);

fprintf('alpha=1/8: %d \n alpha=1/4: %d \n alpha=1/2: %d \n alpha=1: %d \n', pvec(4), pvec(3), pvec(2), pvec(1));
fprintf('pe10: %d \n pe20: %d \n pe40: %d \n', pe10, pe20, pe40);