clc, clear

D = 1;
N = 100;
L = 1.2;
% Varierar denna.
dt = 10^-5;
dx = L/N;
tspan = [0, 0.03];
xvinner = (dx:dx:L-dx);
xv = (0:dx:L);

uv0 = sin(4*pi*xvinner)';
dir1 = @(t) 0 .* t;
dir2 = @(t)(sin(4*pi*L)*exp(-16*pi^2 .* t));

[A, s] = VLE_rums_diskreting(N-1, D, L, dir1, dir2);
func = @(t, uv) (D/(dx^2))*(A*uv + s(t));

tv = (tspan(1):dt:tspan(2));

gfunc = @(t) (D/(dx^2))* s(t);

[~, solm] = ITM((D/(dx^2))*A, gfunc, tv, uv0);

solm = [dir1(tv); solm; dir2(tv)];
%h = surf(solm);

Uana = sin(4*pi .* xv)'*exp(-16*pi^2 .* tv);

err = Uana - solm;
max_err = max(max(abs(err)));
fprintf("Maxfel: %d", max_err);
h = surf(err);

set(h,'LineStyle','none')


