clc, clear

% Konstanter
D = 1;
L = 1.2;
tspan = [0, 0.03];

% Villkor
dir1 = @(t) (0 .* t);
dir2 = @(t)(sin(8*pi*L)*exp(-64*pi^2 .* t));

pvec = zeros(1, 5);
for n=0:4
    % Rumssteg samt vektorer.
    N = 100 * 2^n;
    dx = L/N;
    xv = (0:dx:L);
    xvinner = (dx:dx:L-dx);
    
    % Tidssteg samt vektorer.
    M = floor(0.3 * N); % Proptionel mot N.
    dt = (tspan(2) - tspan(1))/M;
    tv = (tspan(1):dt:tspan(2));
    
    % intiall villkor.
    uv0 = sin(8*pi.*xvinner)';
    
    % Rumsdiskretisering.
    [A, s] = VLE_rums_diskreting(N-1, D, L, dir1, dir2);

    % Anonym funktion för
    gfunc = @(t) (D/(dx^2))* s(t);

    % Löser med implicit metod.
    [~, solminner] = ITM((D/(dx^2))*A, gfunc, tv, uv0);
    solm = [dir1(tv); solminner; dir2(tv)]; 
  
    % Beräknar analytisk lösning och beräknar fel.
    Uana = sin(8*pi .* xv)'*exp(-64*pi^2 .* tv);
    err = norm2(solm(:,end), Uana(:,end));
    pvec(n+1) = err;
    
    fprintf("Tidssteg: dt=%d, M=%d Rumssteg: dx=%d, N=%d ger felet: %d \n", dt, M, dx, N, err);
end

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

