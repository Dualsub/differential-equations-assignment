clc, clear

D = 1;
N = 100;
L = 1.2;
dx = L/N;
dt = 10^-4;
tspan = [0, 0.03];
xv = (0:dx:L);
xvinner = (dx:dx:L-dx);

uv0 = sin(4*pi.*xvinner)';
dir1 = @(t) 0.* t;
dir2 = @(t)(sin(4*pi*L)*exp(-16*(pi^2) .* t));

[A, s] = VLE_rums_diskreting(N-1, D, L, dir1, dir2);

gfunc = @(t) (D/(dx^2))* s(t);

% Beräknar tidsvektor
tend = 0.03;
h = (1/(2^4)) * dt; % Först för det minsta värdet på alpha
tv = h*(0:floor(tend/h)); % Beräknar alla tider i tidsspannet.

Uana = sin(4*pi .* xv)'*exp(-16*pi^2 .* tv);

pvec = zeros(1, 5);
for n=0:4
    tvn = tv(1:2^n:end);
    [~, solminner] = ITM((D/(dx^2))*A, gfunc, tvn, uv0);
    res = dir1(tvn);
    solm = [dir1(tvn); solminner; dir2(tvn)]; 
    diff = solm(2,:) - Uana(2,1:2^n:end);
    err = norm2(solm(:,end), Uana(:,end));
    pvec(n+1) = err; % Fyller backlänges.
end

display(pvec);

% Beräknar noggrannhetsordning
pe10 = log(pvec(1) / pvec(2))/log(2);
pe20 = log(pvec(2) / pvec(3))/log(2);
pe40 = log(pvec(3) / pvec(4))/log(2);
pe80 = log(pvec(4) / pvec(5))/log(2);

fprintf("\n");

fprintf("p10=%f \n", pe10);
fprintf("p20=%f \n", pe20);
fprintf("p40=%f \n", pe40);
fprintf("p80=%f \n", pe80);

%h = surf(err);

%set(h,'LineStyle','none')


