%Defining the transfer function
n =[1];
dn =[1 3 2 0];
g1 = tf(n,dn);
rg1 = order(g1);

% Finding the state space representation
[Ac1, Bc1, Cc1, Dc1]= tf2ss(n,dn);

% Converting to phase variable form
V = fliplr(eye(rg1));
Ap1 =inv(V)*Ac1*V;
Bp1 =Cc1' ;
Cp1 =Bc1' ;
Dp1 =Dc1  ;
disp('Ap1 =');disp(Ap1);
disp('Bp1 =');disp(Bp1);
disp('Cp1 =');disp(Cp1);
disp('Dp1 =');disp(Dp1);

%Testing for controllability
m1 = ctrb(Ap1,Bp1);
disp('M ='); disp(m1);
re1 = rank(m1);
if(re1 == rg1)
    disp('System Is Controllable');
else
    disp('System Is NOT Controllable');
end
% Desired performance parameters
os = 5;
ts = 0.5;
% Determined desired pole location
z  = -log(os/100)/sqrt(pi*pi +log(os/100)^2);
wn = 4/(z*ts);
a  = -z*wn;
b  = wn*sqrt(1-z^2);
Pc = [(a+b*1i),(a-b*1i),10*a];
disp('Pc'); disp(Pc);

% Design controller via pole placement
K1 = place(Ap1,Bp1,Pc);
disp('K1'); disp(K1);

h = ss(Ap1-Bp1*K1,Bp1,Cp1,Dp1);
Apl =h*Ac1;
Bpl =h*Bc1;
Cpl =h*Cc1;
Dpl =h*Dc1;
x = 0:0.0001:10;

step(h,x);

