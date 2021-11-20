function res=G(H,L,v,k2,c2,m2,t)
    [h,hdot] = roadprofile(H,L,v,t);
    res = [0;0;0;(k2*h + c2*hdot)/m2];
end