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
vfunc = @(t, y) quartercar(t,y,A,k2,c2,m2,H,L,v);
tspan = [0, 0.5];
opts = odeset('RelTol', 1e-6, "Refine", 1);
[tv_ode, sol_ODE45] = ode45(vfunc, tspan, v_0, opts);
[tv_e1, sol_Euler1] = EulerF(vfunc, 5 * 10^-3, tspan, v_0);
[tv_e2, sol_Euler2] = EulerF(vfunc, 5 * 10^-4, tspan, v_0);

hold on;
plot(tv_ode, sol_ODE45(:,2));
plot(tv_e1, sol_Euler1(2,:));
plot(tv_e2, sol_Euler2(2,:));
hold off;
legend(["ODE45", "Euler $\Delta t = 5 \cdot 10^{-3}$", "Euler $\Delta t = 5 \cdot 10^{-4}$"], 'Location','best','Interpreter','latex');

title("$z_1$ mot tiden",'Interpreter','latex');
xlabel("Tid $(s)$",'Interpreter','latex');
ylabel("$z_1(m)$",'Interpreter','latex');
saveas(gcf,'plot_U2_iii','epsc');