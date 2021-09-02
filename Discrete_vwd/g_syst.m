function zplus=g_syst(x,c)

% states 
v=x(1);
w=x(2);
d=x(3);

% jump map
zplus=[c;  w+d;d];