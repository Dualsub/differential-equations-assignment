clc, clear

m1 = 460;
m2 = 60;
k1_ref = 5500;
k2_ref = 130000;
k1 = k1_ref;
k2 = 100*k2_ref;
c1 = 300;
c2 = 1300;
v  = (60/3.6);
H = 0.2;
L = 1;

A = [0, 0, 1, 0; 
    0, 0, 0, 1; 
    -k1/m1, k1/m1, -c1/m1, c1/m1; 
    k1/m2, -(k1 + k2)/m2, c1/m2, -(c1 + c2)/m2
    ];

gfunc = @(t) G(H,L,v,k2,c2,m2,t);

v_0 = [0;0;0;0];

% Beräknar t_max
F = @(lambda) -2*real(lambda) / abs(lambda)^2;

eigs = eig(A);
dts = zeros(length(eigs), 1);
for i=1:length(eigs)
   dts(i) = F(eigs(i));
end

t_max = min(dts);
fprintf("T_max: %d", t_max);
% Implementation av implicita trapetsmetoden.
tspan = [0, 1];

alpha_vals = [1, 10, 100];

hold on;
for n=1:length(alpha_vals)
    h = alpha_vals(n) * t_max;
    N = floor((tspan(2) - tspan(1))/h);
    tv = tspan(1)+h*(0:N); % Beräknar alla tider i tidsspannet.
    
    [tv, solm] = ITM(A,tv,gfunc,v_0);
    
    plot(tv, solm(1,:));
end

legend(["$\alpha = 1$", "$\alpha = 10$", "$\alpha = 100$", "ODE45"],'Interpreter','latex');

title_str = "Styvare system med $t_{max} = $" + num2str(t_max) + "$\,s$";
title(title_str, 'Interpreter','latex');
saveas(gcf,'plot_U4_b_i','epsc');