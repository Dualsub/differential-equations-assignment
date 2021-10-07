function [h,hdot] = roadprofile(H,L,v,t);
% Utparametrar: höjden h(t), och dess derivata h'(t)
% Inparametrar: Höjden på guppet H, längden på guppet L, bilens hastighet v och den aktuella tiden t
if(t <= L/v)
    h = (H/2)*(1-cos((2*pi*v*t)/L));
    hdot = (H/2)*((((2*pi*v)/L)*sin((2*pi*v*t)/L)));
else
    h = 0;
    hdot = 0;
end