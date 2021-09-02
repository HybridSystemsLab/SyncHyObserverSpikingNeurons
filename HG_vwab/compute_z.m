function z = compute_z(x,Iext)

v = x(1);
w = x(2);
a = x(3);
b = x(4);

vdot = 0.04*v^2+5*v+140-w+Iext;
wdot = a*(b*v-w);
vdotdot = (0.04*2*v+5)*vdot-wdot;
wdotdot = a*(b*vdot-wdot);

z = [v;vdot;vdotdot;0.04*2*vdot*vdot+(0.04*2*v+5)*vdotdot-wdotdot];

end

