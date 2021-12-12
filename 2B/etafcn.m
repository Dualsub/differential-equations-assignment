function etav = etafcn(yv,delta)
    a = 1 - 2*delta;
    h = @(s) exp(2*exp(-1/s)/(s-1));
    etav = zeros(size(yv));
    for i=(1:length(yv))
       if delta < yv(i) && yv(i) < (1 - delta)
            etav(i) = h((yv(i)-delta)/a) / (h((yv(i)-delta)/a) + h((1-yv(i)-delta)/a));
       elseif yv(i) < delta
           etav(i) = 1;
       else
           etav(i) = 0;
       end
end