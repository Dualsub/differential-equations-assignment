clc, clear

m1 = 460;
m2 = 60;
k1_ref = 5500;
k2_ref = 130000;
k1 = k1_ref;
k2 = k2_ref;
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
v_0 = [0;0;0;0];

alpha_vals = [0.9, 1, 1.1, 1.5];
t_max = 0.0118;

vfunc = @(t, y) quartercar(t,y,A,k2,c2,m2,H,L,v);
hold on;
for i=1:length(alpha_vals)
    [tv, solm] = EulerF(vfunc, t_max * alpha_vals(i), [0, 1], v_0);
    plot(tv, solm(2,:));
end
hold off;

legend(["$\alpha = 0.9$", "$\alpha = 1$", "$\alpha = 1.1$", "$\alpha = 1.5$"],'Interpreter','latex')
title("$z_2$ mot tiden med olika $\alpha$",'Interpreter','latex');
xlabel("Tid $(s)$",'Interpreter','latex');
ylabel("$z_2(m)$",'Interpreter','latex');
saveas(gcf,'plot_U3_iii','epsc');