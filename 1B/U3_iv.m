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

% Beräknar t_max
F = @(lambda) -2*real(lambda) / abs(lambda)^2;

eigs = eig(A);
dts = zeros(length(eigs), 1);
for i=1:length(eigs)
   dts(i) = F(eigs(i));
end

t_max = min(dts);
dt = t_max * 0.1;

% Beräknar lösningen
v_0 = [0;0;0;0];

tspan = [0, 1];
vfunc = @(t, y) quartercar(t,y,A,k2,c2,m2,H,L,v);

[tv, solm] = EulerF(vfunc, dt, tspan, v_0);
plot(tv, solm(1:2,:));
title_str = ["Styvare system med $\Delta t = 0.1 \cdot t_{max} = $" + num2str(dt) + "$\,s$"];
legend(["$z_1$", "$z_2$"],'Interpreter','latex');
title(title_str, 'Interpreter','latex');
xlabel("Tid $(s)$",'Interpreter','latex');
ylabel("$z_1 / z_2 \, (m)$",'Interpreter','latex');
saveas(gcf,'plot_U3_iv','epsc');