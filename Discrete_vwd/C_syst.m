function value=C_syst(x,vm)

v=x(1);
w=x(2);

if v<vm
    value=1; % report flow 
else
    value=0; % do not report flow
end
