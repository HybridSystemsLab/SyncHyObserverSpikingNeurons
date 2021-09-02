
close all
clear all                                                               
clc     

%system parameters
Iext=10;a=0.02;b=0.2;c=-55;d=4;vm=30;

% initial conditions                                                    
x0 = [-55; -6; d]; 
%zHat0 = x0;
zHat0 = [-20;0;2];

% simulation horizon                                                    
T = 1000;                                                                 
J = 500;                                                                 
                                                                        
% rule for jumps                                                        
% rule = 1 -> priority for jumps                                        
% rule = 2 -> priority for flows                                        
% rule = 3 -> no priority, random selection when simultaneous conditions
rule = 1;                                                               
                                                                        
%solver tolerances
RelTol = 1e-6;
MaxStep = 1;

% Measurement delay : use only with Discretevwd_jumpDeltaj.slx !
delay_m = 0; % delay in detecting jump
delayHat_m = delay_m; % estimation of the delay maybe for delay compensation in observer jump map

% Observer 
Ad = [0,0,0;0,1,1;0,0,1]; % with injection of y in \dot\hatw
Hd = [1,0,0];
Ac = [0,-1,0;0,-a,0;0,0,0];
Ld = [0;-0.0028;-0.0063]; % run computation_Ld with nilpotent case
% Ac = [0,-1,0;a*b,-a,0;0,0,0]; % without injection of y in \dot\hatw
% Ld = [0;0.0572;-0.0008]; % run computation_Ld with non nilpotent case

tau = linspace(5,50,1000);
max_eig = zeros(length(tau),3);
for ind=1:length(tau)
    max_eig(ind,:)=abs(real(eig((Ad-Ld*Hd)*expm(Ac*tau(ind)))))';
    X = eig(expm(Ac*tau(ind))*(Ad-Ld*Hd));
    max_eig(ind,:)=abs(X)';
end
figure(1)
plot(tau,max_eig)
xlabel('$\tau$','Interpreter','latex')

%% simu

sim('Discretevwd')
%sim('Discretevwd_jumpDeltaj') % for simulation with output delay

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
figure(2) 
subplot(2,2,1)
plotHarc([t,tHat],[j,jHat],[x(:,1),xHat(:,1)],[],modificatorF,modificatorJ);
grid on;
leg11 = legend('$x_1$','$\hat{x}_1$');
set(leg11, 'Interpreter', 'latex','Fontsize',12)
xlabel('Time')
subplot(2,2,2)
plotHarc([t,tHat],[j,jHat],[x(:,2),xHat(:,2)],[],modificatorF,modificatorJ);
grid on
leg12 = legend('$x_2$','$\hat{x}_2$');
set(leg12, 'Interpreter', 'latex','Fontsize',12)
xlabel('Time')
subplot(2,2,3)
plotHarc([t,tHat],[j,jHat],[x(:,3),xHat(:,3)],[],modificatorF,modificatorJ);
grid on
leg13 = legend('$d$','$\hat{d}$');
set(leg13, 'Interpreter', 'latex','Fontsize',12)
xlabel('Time')


error = x-xHat;
norm_error = sqrt(error(:,1).^2+error(:,2).^2+error(:,3).^2);

% plot error
figure(3) 
clf
plotHarc([t,t,t],[jRes,jRes,jRes],[error(:,1),error(:,2),error(:,3)],[],modificatorF,modificatorJ);
hold on;grid on
leg2=legend('$e_1$','$e_2$','$e_3$');
set(leg2, 'Interpreter', 'latex')
%title('Estimation error')
xlabel('$t$')
grid on

% % plot solution 2D
% v=x(:,1);
% w=x(:,2);    
% vHat=xHat(:,1);
% wHat=xHat(:,2); 
% figure(4);
% modificator{1} = '-';   
% modificator{2} = 'LineWidth';
% modificator{3} = 2;
% plotHarc([v,vHat],[j,jHat],[w,wHat],[],modificator);
% grid on;
% xlabel('v (mV)');
% ylabel('w');
% grid on;box on; 
% hold on;
% leg3=legend('$x$','$\hat{x}$');
% set(leg3, 'Interpreter', 'latex')

% load norm_error_D0
% load norm_error_D5
% load norm_error_D10
% % plot error with delays
% figure(1) 
% subplot(2,2,4)
% modificatorF{1} = 'm-';
% modificatorJ{1} = 'm--';
% plotHarc(norm_error5(:,1),norm_error5(:,2),norm_error5(:,3),[],modificatorF,modificatorJ);
% hold on;grid on
% modificatorF{1} = 'b-';
% modificatorJ{1} = 'b--';
% plotHarc(norm_error1(:,1),norm_error1(:,2),norm_error1(:,3),[],modificatorF,modificatorJ);
% hold on;
% modificatorF{1} = 'r-';
% modificatorJ{1} = 'r--';
% plotHarc(norm_error0(:,1),norm_error0(:,2),norm_error0(:,3),[],modificatorF,modificatorJ);
% xlabel('$t$ [s]', 'Interpreter', 'latex')
% grid on
