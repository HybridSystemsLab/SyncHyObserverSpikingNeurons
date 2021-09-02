function zplus=g_syst(x,c,d)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Xuyang Lou, Yuchun Li
%
% Project: Simulation of a hybrid system
%
% Name: g.m
%
% Description: Jump map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% states 
v=x(1);
w=x(2);
a=x(3);
b=x(4);

% jump map
zplus=[c;  w+d; a; b];