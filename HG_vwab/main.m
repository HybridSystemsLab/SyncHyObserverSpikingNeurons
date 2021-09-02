
close all
clear all                                                               
clc     

%system parameters
Iext=10;a=0.02;b=0.2;c=-55;d=4;

% initial conditions                                                    
x0 = [-55;-6;a;b]; 
xHat0 = [-50;0; 0.1;0.1];
%xHat0 = x0;
zHat0 = compute_z(xHat0,Iext);

% simulation horizon                                                    
T = 30;                                                                 
J = 10;                                                                 
                                                                        
% rule for jumps                                                        
% rule = 1 -> priority for jumps                                        
% rule = 2 -> priority for flows                                        
% rule = 3 -> no priority, random selection when simultaneous conditions
rule = 1;                                                               
                                                                        
%solver tolerances
RelTol = 1e-7;
MaxStep = 1e-2;

% Measurement
delay_m = 0; % 0.01; % delay in processing outpout and detecting jump
delayHat_m = delay_m; % estimation of the delay maybe for delay compensation in observer jump map

% Observer 
ll = 4;

%% simu

sim('HGvwab')

%% Post-processing

% construction of resulting jump vector
jRes = zeros(size(j));
for ind=2:length(jRes)
    if j(ind)~=j(ind-1) || jHat(ind)~=jHat(ind-1)
        jRes(ind) = jRes(ind-1)+1;
    else 
        jRes(ind) = jRes(ind-1);
    end
end

modificatorF{1} = '-';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 2;
modificatorJ{1} = '--';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 1.2;

% plot solution 
figure(1) 
clf
subplot(2,2,1), plotHarc([t,tHat],[j,jHat],[x(:,1),xHat(:,1)],[],modificatorF,modificatorJ);
grid on
leg11 = legend('$x_1$','$\hat{x}_1$');
set(leg11, 'Interpreter', 'latex','Fontsize',15)
xlabel('$t$ [s]','Interpreter','latex')
subplot(2,2,2), plotHarc([t,tHat],[j,jHat],[x(:,2),xHat(:,2)],[],modificatorF,modificatorJ);
grid on
leg12 = legend('$x_2$','$\hat{x}_2$');
axis([0 T -10 5])
xlabel('$t$ [s]','Interpreter','latex')
set(leg12, 'Interpreter', 'latex','Fontsize',15)
subplot(2,2,3), plotHarc([t,tHat],[j,jHat],[x(:,3),xHat(:,3)],[],modificatorF,modificatorJ);
grid on
leg13 = legend('$a$','$\hat{a}$');
axis([0 T 0 0.1])
xlabel('$t$ [s]','Interpreter','latex')
set(leg13, 'Interpreter', 'latex','Fontsize',15)
subplot(2,2,4), plotHarc([t,tHat],[j,jHat],[x(:,4),xHat(:,4)],[],modificatorF,modificatorJ);
grid on
leg14 = legend('$b$','$\hat{b}$');
set(leg14, 'Interpreter', 'latex','Fontsize',15)
axis([0 T 0 0.4])
xlabel('$t$ [s]','Interpreter','latex')

% plot solution in z-coordinates
figure(2) 
clf
subplot(2,2,1), plotHarc([t,tHat],[j,jHat],[z(:,1),zHat(:,1)],[],modificatorF,modificatorJ);
grid on
leg11 = legend('$z_1$','$\hat{z}_1$');
set(leg11, 'Interpreter', 'latex')
subplot(2,2,2), plotHarc([t,tHat],[j,jHat],[z(:,2),zHat(:,2)],[],modificatorF,modificatorJ);
grid on
leg12 = legend('$z_2$','$\hat{z}_2$');
set(leg12, 'Interpreter', 'latex')
subplot(2,2,3), plotHarc([t,tHat],[j,jHat],[z(:,3),zHat(:,3)],[],modificatorF,modificatorJ);
grid on
leg13 = legend('$z_3$','$\hat{z}_3$');
set(leg13, 'Interpreter', 'latex')
subplot(2,2,4), plotHarc([t,tHat],[j,jHat],[z(:,4),zHat(:,4)],[],modificatorF,modificatorJ);
grid on
leg14 = legend('$z_4$','$\hat{z}_4$');
set(leg14, 'Interpreter', 'latex')

error = x-xHat;

% plot estimation error
figure(3)
clf
plotHarc([t,t,t,t],[jRes,jRes,jRes,jRes],[error(:,1),error(:,2),error(:,3),error(:,4)],[],modificatorF,modificatorJ);
hold on;grid on
leg2=legend('$e_1$','$e_2$','$e_3$','$e_4$');
set(leg2, 'Interpreter', 'latex','Fontsize',15)
title('Estimation error')
xlabel('$t$ [s]','Interpreter', 'latex')
grid on

% plot solution 2D
v=x(:,1);
w=x(:,2);    
vHat=xHat(:,1);
wHat=xHat(:,2); 
    
% plot solution
figure(4);
modificator{1} = '-';   % red line for plant
modificator{2} = 'LineWidth';
modificator{3} = 2;
plotHarc([v,vHat],[j,j],[w,wHat],[],modificator);
grid on;
xlabel('$v$ [mV]','Interpreter', 'latex');
ylabel('$w$','Interpreter', 'latex');
leg2=legend('$x$','$\hat{x}$');
set(leg2, 'Interpreter', 'latex','Fontsize',15)




