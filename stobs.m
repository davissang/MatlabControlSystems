% The system matrices
R = [0 1 0; 0 0 1; 2.4 3.6 -4.5;];
S = [0;0;2.4];
T = [1 0 0];
F = [0];

% Test for observability
N = obsv(R, T);
rankN = rank(N);
disp('Observable Matrix is N = ');
disp(N);
if(rankN == rank(R))
disp('Given System is Observable.');
else
disp('Given System is Unobservable');
end
% Observer Gain matrice from the desired eigenvalues
P = [-2+6.9282i -2-6.9282i -5];
gt = place(R',T',P);
G =reshape(gt,[3,1]);
disp('G ='); disp(G);

Robs = [R-G*T];
Sobs = [S G];
Tobs = eye(3);
Fobs = [0 0; 0 0; 0 0];
