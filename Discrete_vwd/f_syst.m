function xdot=f_syst(x,a,b,Iext)

% states 
v = x(1);
w = x(2);
d = x(3);

% flow map
xdot=[0.04*v^2+5*v+140-w+Iext;a*(b*v-w);0];

