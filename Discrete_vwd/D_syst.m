function value=D_syst(x,vm)

v = x(1);
w = x(2);

if v >= vm     % jump condition 
    value = 1;  % report jump
else
    value = 0;  % do not report jump
end
