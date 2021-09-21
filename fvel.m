function ds = fvel(t,s,b,aL,aR,wL,wR)
    % wL, wR initial velocities for the left and the right wheels
    % aL, aR, acceleration. (aL = aR = 0 leads to circular motion)
    % b is length between wheels.
    % s has three components: (x,y,theta). 
    % t is time. 
    % Returning ds/dt, vector with three components (dx/dt,dy/dt,d theta/dt).
    
    % Skriver upp givna samband.
    vR = aR*t + wR;
    vL = aL*t + wL;
    v = (vR + vL)/2;
    % Använder hastigheten och theta(tredje komponenten i S) för att beräkna x och y.
    dx = v*cos(s(3));
    dy = v*sin(s(3));
    % Beräknar derivatan av theta med det givna sambandet.
    dtheta = (vR - vL)/b;

    ds = [dx; dy; dtheta];
end

