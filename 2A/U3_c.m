clc, clear


% Konstanter
D = 1;
N = 100;
L = 1.2;

% Tids/rums-steg samt vektorer.
factor = 0.9;
dx = L/N;
tspan = [0, 0.03];
xvinner = (dx:dx:L-dx);
xv = (0:dx:L);

% Villkor
uv0 = sin(4*pi*xvinner)';
dir1 = @(t) (0 .* t);
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
% Sätter dt baserat på t_max.
dt = t_max * factor;
fprintf("t_max: %d \n", t_max);

% Tidsvektorn.
tv = (tspan(1):dt:tspan(2));

% Beräknar tidsvektorn m.h.a av dt.
func = @(t, uv) (D/(dx^2))*(A*uv + s(t));

% Löser med Euler framåt.
[~, solminner] = EulerF(func, dt, tspan, uv0);

% Lägger till randvillkoren.
solm = [dir1(tv); solminner; dir2(tv)];

% Beräknar analytisk lösning och jämför.
Uana = sin(4*pi .* xv)'*exp(-16*pi^2 .* tv);
err = Uana - solm;
max_err = max(max(abs(err)));
fprintf("Maxfel: %d", max_err);
h = surf(err);

set(h,'LineStyle','none')


