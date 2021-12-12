clc, clear

% Konstanter
D = 1;
N = 50;
L = 1.2;

% Tids/rums-steg samt vektorer.
dt = 0.0004;
dx = L/N;
tspan = [0, 0.03];
xvinner = (dx:dx:L-dx);
xv = (0:dx:L);

% Villkor
uv0 = sin(4*pi*xvinner)';
dir1 = @(t) (0 .* t);
dir2 = @(t)(sin(4*pi*L)*exp(-16*pi^2 .* t));

% Diskritisering i rummet.
[A, s] = VLE_rums_diskreting(N-1, D, L, dir1, dir2);
% Anonym funktion som ger u(t, x) vid tiden t.
func = @(t, uv) (D/(dx^2))*(A*uv + s(t));

% Löser inre punkter med Euler.
[tv, solminner] = EulerF(func, dt, tspan, uv0);

% Lägger till randvillkoren.
solm = [dir1(tv); solminner; dir2(tv)];
h = surf(solm);

% Beräknar analytisk lösning och jämför.
Uana = sin(4*pi .* xv)'*exp(-16*pi^2 .* tv);
err = abs(Uana - solm);
max_err = max(max(err));
fprintf("Maxfel: %d", max_err);
%h = surf(err);
set(h,'LineStyle','none')


