function condinv = compute_cond_inv_z(z,Iext)

v = z(1);
w = 0.04*z(1)^2+5*z(1)+140-z(2)+Iext;
vdot = z(2);

wdot = (0.04*2*v+5)*z(2)-z(3);

condinv = cond([v,-w;vdot,-wdot]);

end

