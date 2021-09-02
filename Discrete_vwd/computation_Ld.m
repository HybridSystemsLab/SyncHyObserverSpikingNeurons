%% Nilpotent case

Ac = [0,-1,0;0,-a,0;0,0,0];
Ad = [0,0,0;0,1,1;0,0,1];
Hd = [1,0,0];

P = sdpvar(3,3);
Ltilde = sdpvar(3,1);
taumin = 30;
taumax = 50;
Mmin = [P,(eye(3)+taumin*Ac)'*(P*Ad-Ltilde*Hd)';(P*Ad-Ltilde*Hd)*(eye(3)+taumin*Ac),P];
Mmax = [P,(eye(3)+taumax*Ac)'*(P*Ad-Ltilde*Hd)';(P*Ad-Ltilde*Hd)*(eye(3)+taumax*Ac),P];
constraints = [P>=0,Mmin<=0,Mmax<=0];

%objective = -a_c;
%options = sdpsettings('verbose',1,'solver','linprog','quadprog.maxiter',100);

sol = optimize(constraints);

% Analyze error flags
if sol.problem == 0
 % Extract and display value
 L = inv(value(P))*value(Ltilde)
else
 display('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end


%% Polytopic embedding

Ac = [0,-1,0;a*b,-a,0;0,0,0];
Ad = [0,0,0;0,1,1;0,0,1];
Hd = [1,0,0];

taumin = 30;
taumax = 50;

Lambda = eig(Ac);
% V = [ones(1,3);Lambda';Lambda'.^2]; % vandermonde matrix % if multiplicity=1
% Vinv = inv(V);
% F = kron(Vinv,eye(3))*[eye(3);A_c;A_c^2];
res = compute_residues(Ac,eye(3),eye(3));
F1 = res(1:3,:);
F2 = res(4:6,:);
F3 = res(7:9,:);
betabornes = zeros(3,4);
for k=1:3
    l = Lambda(k);
    if isreal(l)
        betabornes(k,:) = [exp(l*taumin),exp(l*taumax),0,0]; % if multiplicity=1
    else
        betabornes(k,:) = [2*exp(real(l)*taumin)*cos(imag(l)*taumin),2*exp(real(l)*taumax)*cos(imag(l)*taumax),-2*exp(real(l)*taumin)*sin(imag(l)*taumin),-2*exp(real(l)*taumax)*sin(imag(l)*taumax)];
    end
end
% % if 3 real eigenvalues
% M = zeros(3,3,8);
% ind = 1;
% for k = 1:2
%     for j=1:2
%         for l=1:2
%             M(:,:,ind) = F1*betabornes(1,k)+F2*betabornes(2,j)+F3*betabornes(3,l);
%             ind = ind+1;
%         end
%     end
% end
% if 1 real eigenvalue and Lambda = (complex,complex,real)
M = zeros(3,3,32);
ind = 1;
for k = 1:2
    for j=1:2
        for jj=3:4
            for l=1:2
                for ll=3:4
                    M(:,:,ind) = real(F1)*betabornes(1,j)+imag(F1)*betabornes(1,jj)+real(F2)*betabornes(2,l)+imag(F2)*betabornes(2,ll)+F3*betabornes(3,k);
                    ind = ind+1;
                end
            end
        end
    end
end

sizeM = size(M);
P = sdpvar(3,3);
Ltilde = sdpvar(3,1);
constraints = [P>=0];
for k=1:sizeM(3)
    cons = [P,M(:,:,k)'*(P*Ad-Ltilde*Hd)';(P*Ad-Ltilde*Hd)*M(:,:,k),P];
    constraints = [constraints,cons<=0];
end
sol = optimize(constraints);

% Analyze error flags
if sol.problem == 0
 % Extract and display value
 L = inv(value(P))*value(Ltilde)
else
 display('Hmm, something went wrong!');
 sol.info
 yalmiperror(sol.problem)
end
