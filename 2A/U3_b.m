clc, clear

D = 1;
N = 100;
L = 1.2;
dt = 10^-5;
dx = L/N;
tspan = [0, 0.03];
X = (dx:dx:L-dx);

uv0 = sin(4*pi*X)';
dir1 = 0;
dir2 = @(t)(sin(4*pi*L)*exp(-16*pi^2 .* t));

[A, s] = VLE_rums_diskreting(N-1, D, L, dir1, dir2);

full(A);

func = @(t, uv) uv + (D*dt/dx^2)*(A*uv + s(t));

[tv, solm] = EulerF(func, dt, tspan, uv0);

dir1res = zeros(1, length(tv));
dir2res = dir2(tv);

solm = [dir1res; solm; dir2res];
h = surf(solm);

UanaEkv = @(x, t) sin(4*pi .* x)'*exp(-16*pi^2 .* t);

Uana = UanaEkv((0:dx:L), tv);
%h = surf(Uana);

err = Uana - solm;
max_err = max(max(abs(err)));
fprintf("Maxfel: %d", max_err);
%h = surf(err);

set(h,'LineStyle','none')


