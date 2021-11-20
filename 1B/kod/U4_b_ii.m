clc, clear

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

t_0 = min(dts);

% Beräknar tidsvektor
tend = 0.05;
h = 0.1 * t_0;
N = floor(tend/h);
tv = h*(0:N); % Beräknar alla tider i tidsspannet.

% Beräknar referenslösning med ODE45.
opts = odeset('RelTol', 1e-9, 'AbsTol', 1e-9);
[tvref, yref] = ode45(vfunc, tv, v_0, opts);

% Beräknar med ITM.
[tv, solm] = ITM(A,tv,gfunc,v_0);

% Normen av felet tas nu fram nu.
errvec = solm(2,:)' - yref(:,2);
err = max(abs(errvec));
disp(err);
