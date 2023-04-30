
neighbor(tx,ok).
neighbor(ok,co).
neighbor(co,tx).
neighbor(X_G,Y_G):-neighbor(Y_G,X_G),region(Y_G),region(X_G).
1{has(X_G,C_G):color(C_G),region(X_G)}1:-region(X_G).
:-neighbor(X_G,Y_G),has(X_G,C_G),has(Y_G,C_G),region(X_G),region(Y_G),color(C_G).
region(tx).
region(ok).
region(co).
color(red).
color(green).
color(blue).
has_(X1,X2):-has(X1,X2).
has__(X1,X2):--has(X1,X2).

neighbor_(X1,X2):-neighbor(X1,X2).
neighbor__(X1,X2):--neighbor(X1,X2).
% has_ has__ neighbor_ neighbor__



