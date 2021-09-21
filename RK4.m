function [tv, solm]=RK4(func, h, tspan, yv0)
    % Implementation av RK4.
    N = round((tspan(2) - tspan(1))/h);
    solm = [yv0; zeros(N, length(yv0))]; % Sätter yv0 som initalvärden.
    tv = tspan(1)+h*(0:N); % Beräknar alla tider i tidsspannet.
    % Utför loopen och beräknar varje del för varje t i intervallet.
    for i=1:N
        c1=func(tv(i), solm(i,:))';
        c2=func(tv(i)+h/2, solm(i,:) + (h/2)*c1)';    
        c3=func(tv(i)+h/2, solm(i,:) + (h/2)*c2)';
        c4=func(tv(i)+h, solm(i,:)+h*c3)';
        % Summerar bidragen och beräknar värdet.
        ctot = c1+2*c2+2*c3+c4;
        solm(i+1,:) = solm(i,:) + (h/6) * ctot;
    end
end

