clc, clear

% Konstanter
D = 1;
N = 50;
L = 1;

% Tids/rums-steg samt vektorer.
dt = 0.004;
dx = L/N;
tspan = [0, 0.03];
tv = (tspan(1):dt:tspan(2));
xvinner = (dx:dx:L-dx);
xv = (0:dx:L);

% Villkor
uv0 = sin(4*pi*xvinner)';
dir1 = @(t) (0 .* t);
dir2 = @(t)(sin(4*pi*L)*exp(-16*pi^2 .* t));

% Rumsdiskretiserar.
[A, s] = VLE_rums_diskreting(N-1, D, L, dir1, dir2);
func = @(t, uv) (D/(dx^2))*(A*uv + s(t));

gfunc = @(t) (D/(dx^2))* s(t);

% Löser med CN, implicita metoden.
[~, solm] = ITM((D/(dx^2))*A, gfunc, tv, uv0);
% Sätter in villkor för att utvinna lösning.
solm = [dir1(tv); solm; dir2(tv)];

h = surf(solm);

% Beräknar analytisk lösning och jämför.
Uana = sin(4*pi .* xv)'*exp(-16*pi^2 .* tv);
err = abs(Uana - solm);
max_err = max(max(err));
fprintf("Maxfel: %d", max_err);
%h = surf(err);

set(h,'LineStyle','none')


