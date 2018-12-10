function [Y_,X_,U,lambda,PN1]=init(A,Adj,eta)

[nada nNodos]=size(A);
[nada f]=size(A{1});n=f-1;


PN1=zeros(n+1);PN1(n+1,n+1)=1;
lambda ={};

for j = 1:nNodos
    [nDatosi nada]=size(A{j});
    
    Y_{j} = diag(A{j}(:,3));
    X_{j} = [A{j}(:,1:n),ones(nDatosi,1)]; 
    U{j} = (1+2*eta*sum(Adj(j,:))).*eye(n+1) - PN1;
end

end