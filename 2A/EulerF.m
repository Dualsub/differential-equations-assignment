function [tv, solm]=EulerF(func, h, tspan, yv0)
    % Implementation av EulerF.
    N = floor((tspan(2) - tspan(1))/h);
    solm = [yv0 zeros(length(yv0), N)]; % Sätter yv0 som initalvärden.
    tv = tspan(1)+h*(0:N); % Beräknar alla tider i tidsspannet.
    % Utför loopen och beräknar för varje t i intervallet.
    for i = 1:N
        solm(:,i+1) = solm(:,i) + h*func(tv(i), solm(:,i));
    end
end

