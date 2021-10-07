
m1 = 460;
m2 = 60;
k1_ref = 5500;
k2_ref = 130000;
k1 = k1_ref;
k2 = k2_ref;
c1 = 300;
c2 = 1300;
v  = (60/3.6);
H = 0.2;
L = 1;

A = [0, 0, 1, 0; 
    0, 0, 0, 1; 
    -k1/m1, k1/m1, -c1/m1, c1/m1; 
    k1/m2, -(k1 + k2)/m2, c1/m2, -(c1 + c2)/m2
    ];
v_0 = [0;0;0;0];
vfunc = @(t, y) quartercar(t,y,A,k2,c2,m2,H,L,v);
[tv, solm] = EulerF(vfunc, 5*10^-3,[0, 1], v_0);
plot(tv, solm)