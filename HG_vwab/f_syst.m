function xdot=f_syst(x,Iext)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matlab M-file                Author: Xuyang Lou, Yuchun Li
%
% Project: Simulation of a hybrid system
%
% Name: f.m
%
% Description: Flow map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% states 
v = x(1);
w = x(2);
a = x(3);
b = x(4);

% flow map
xdot=[0.04*v^2+5*v+140-w+Iext;a*(b*v-w);0;0];

