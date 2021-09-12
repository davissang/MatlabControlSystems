%Defining the transfer function
num =[5];
den =[1 6 11 6];
g = tf(num,den);
rg = order(g);

% Finding the state space representation
[Ac, Bc, Cc, Dc]= tf2ss(num,den);

% Converting to phase variable form
V = fliplr(eye(rg));
Ap =inv(V)*Ac*V;
Bp =Cc' ;
Cp =Bc' ;
Dp =Dc  ;
disp('Ap =');disp(Ap);
disp('Bp =');disp(Bp);
disp('Cp =');disp(Cp);
disp('Dp =');disp(Dp);

%Testing for controllability
m = ctrb(Ap,Bp);
disp('m ='); disp(m);
re = rank(m);
if(re == rg)
    disp('System Is Controllable');
else
    disp('System Is NOT Controllable');
end

% Evaluating for K
pk=[-4+(20^0.5)*1i -4-(20^0.5)*1i -5];
disp('pK =');disp(pk);
K=place(Ap,Bp,pk);
disp('K =');disp(K);



