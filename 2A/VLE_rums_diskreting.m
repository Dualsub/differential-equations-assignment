function [A, s] = VLE_rums_diskreting(N, D, L, dir1, dir2)
    dx = L/N;
    d1 = -2 * ones(N, 1);
    d2 = ones(N, 1);
    
    A = spdiags([d2 d1 d2], -1:1, N, N);
    
    s = @(t) [dir1(t); zeros(N-2, 1); dir2(t)];
end

