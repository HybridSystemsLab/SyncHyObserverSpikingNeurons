function condinv = compute_cond_inv(x,Iext)

v = x(1);
w = x(2);
a = x(3);
b = x(4);

vdot = 0.04*v^2+5*v+140-w+Iext;
wdot = a*(b*v-w);


condinv = cond([v,-w;vdot,-wdot]);

end

