function [tv, solm]=ITM(A, gfunc, tv, y_0)
    % Innan loopen beräknar vi de matriser som inte ändras med tiden.
    
    % Antar konstant tidssteg.
    h = tv(2) - tv(1);
    fprintf("h:%d\n", h);
    N = length(tv)-1;
    solm = [y_0 zeros(length(y_0), N)]; % Sätter yv0 som initalvärden.

    % Beräknar matriser
    I = speye(length(A(1,:)));
    B = (I - (h/2) * A);
    C = (I + (h/2) * A);
    
    for i = 1:N
        f = (h/2)*(gfunc(tv(i)) + gfunc(tv(i+1)));
        solm(:,i+1) = B\(C*solm(:,i) + f);
    end


end