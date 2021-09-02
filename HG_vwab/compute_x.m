function x = compute_x(z,Iext)

v = z(1);
w = 0.04*z(1)^2+5*z(1)+140-z(2)+Iext;
vdot = z(2);

wdot = (0.04*2*v+5)*z(2)-z(3);
wdotdot = 0.04*2*z(2)*z(2)+(0.04*2*v+5)*z(3)-z(4);

A = [v,-w;vdot,-wdot];
B = [wdot;wdotdot];
par = A\B; % [ab;a]

x = [v;w;min(max(par(2),0),1);min(max(par(1)/max(par(2),0.001),0),1)];

end

