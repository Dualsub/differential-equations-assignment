clc, clear

D = 1;
N = 100;
L = 1.2;
factor = 0.9;
dx = L/N;
tspan = [0, 0.03];
xvinner = (dx:dx:L-dx);
xv = (0:dx:L);

uv0 = sin(4*pi*xvinner)';
dir1 = @(t) 0 .* t;
dir2 = @(t)(sin(4*pi*L)*exp(-16*pi^2 .* t));

[A, s] = VLE_rums_diskreting(N-1, D, L, dir1, dir2);

% Beräknar t_max
F = @(lambda) (2*dx^2) / (D*abs(lambda));

eigs = eig(A);
dts = zeros(length(eigs), 1);
for i=1:length(eigs)
   dts(i) = F(eigs(i));
end

t_max = min(dts);
dt = t_max * factor;

fprintf("t_max: %d \n", t_max);

tv = (tspan(1):dt:tspan(2));

func = @(t, uv) (D/(dx^2))*(A*uv + s(t));

[~, solm] = EulerF(func, dt, tspan, uv0);

solm = [dir1(tv); solm; dir2(tv)];
%h = surf(solm);

Uana = sin(4*pi .* xv)'*exp(-16*pi^2 .* tv);

err = Uana - solm;
max_err = max(max(abs(err)));
fprintf("Maxfel: %d", max_err);
h = surf(err);

set(h,'LineStyle','none')


