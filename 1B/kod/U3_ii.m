clc, clear

% Givna systemparametrar.
m1 = 460; m2 = 60;
k1_ref = 5500; k2_ref = 130000;
k1 = k1_ref; k2 = k2_ref;
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
% Framtaget stabilitetsvillkor.
F = @(lambda) -2*real(lambda) / abs(lambda)^2;

eigs = eig(A);
dts = zeros(length(eigs), 1); % Array av värden med F(lambda) för olika egenvärden.
for i=1:length(eigs) % Värderar F för varje egenvärde.
   dts(i) = F(eigs(i));
end

% Sätter de minsta värdet till t_max.
t_max = min(dts);

fprintf('T_max = %d', t_max);
