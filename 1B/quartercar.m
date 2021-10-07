function dy = quartercar(t,y,A,k2,c2,m2,H,L,v)
% Utparameter: dy. Funktionen definierar och returnerar högerledet i systemet dy/dt = A*y(t) + g(t)
% Inparametrar: Tidpunkt t, lösningsvektor y(t), systemmatris A, konstanter k2, c2, m2, H, L, v
[h,hdot] = roadprofile(H,L,v,t);
g = [0;0;0;(k2*h + c2*hdot)/m2];
dy = A*y + g;

end
