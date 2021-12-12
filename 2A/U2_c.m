clc, clear

Uana = @(x) (1/3) * exp(2.*x) + (2/3) * exp(-2.*x);

N = 200;
[A, f] = diskretisering(N);
U_inner = A\f;
U = [1; U_inner];
X = 0:1/N:1;
display(norm2(U, Uana(X)'));

pvec = zeros(6, 1);

for i=0:5
    N = 50*2^i;
    [A, f] = diskretisering(N);
    U_inner = A\f;
    U = [1; U_inner];
    X = 0:1/N:1;
    pvec(i+1) = norm2(U, Uana(X)');
    fprintf("Tidsstegen: %d ger 2-felet: %f \n", N, pvec(i+1));
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
