function [A,f] = diskretisering(N)
    h = 1/N;
    d1 = -(2/(h^2)+4) * ones(N, 1);
    d2 = (1/h^2)*ones(N, 1);
    
    A = spdiags([d2 d1 d2], -1:1, N, N);
    A(end, end-2:end) = [1/(2*h) -2/h 3/(2*h)];
    
    f = zeros(N, 1);
    f(1) = -1/h^2;
    f(end) = exp(2) - exp(-2);
end

