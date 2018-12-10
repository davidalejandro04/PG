clc
clear
%%%%%%%%%%%
%Constantes
%%%%%%%%%%%


start  = 0;
nIters = 100;
nDatos1=20;
nDatos2=20;
nDatos=nDatos1+nDatos2;
eta=50;
C=1/10.0;

mu = [6 3];
mu2=[-2 2];

% mu = [2 -2];
% mu2=[0 2];
sigma2 = [1 0; 0 2];
sigma= [1 0.5; 0.5 1];

%%%%%%%%%%%
%%%%%%%%%%%

%Adj=generarAdj(nNodos);
Adj=[0,1,0;1,0,1;0,1,0]; 
%Adj=[0,1,0,1;1,0,1,0; 0,1,0,1; 1,0,1,0]; 

G=graph(Adj)
plot(G)

[nNodos nCols] = size(Adj);
%n: numero de features; Nj = numero de nodos; 

n = 1; Nj =nNodos;


for k = 1:nNodos
    Bj{k} = find(Adj(k,:),nNodos);
end

for j=1:nNodos
    sprev = rng(0,'v5uniform');
    rng(sprev);

    X_1 = mvnrnd(mu,sigma,nDatos1);
    X_2 = mvnrnd(mu2,sigma2,nDatos2);
    x=[X_1;X_2]';y=[ones(1,nDatos1) -ones(1,nDatos2)];
    A{j} = [ -((ones(n,1)*y).*x)' -y'];  
end


% t = 0;
PN1=zeros(n+1);PN1(n+1,n+1)=1;
lambda ={};

%%%%%%%%%%%%
%%%Randomly initialize vj(0) and alpha(0)
%%%%%%%%%%%%
for j = 1:nNodos
    Y_{j} = diag(A{j}(:,3));
    X_{j} = [A{j}(:,1:n),ones(nDatos,1)]; 
    U{j} = (1+2*eta*sum(Adj(j,:))).*eye(n+1) - PN1;
    VE{j} = randn(n+1,1);  
    alpha{j} = randn(n+1,1);
end

ve100=VE{1};
ve200=VE{2};
ve300=VE{3};


for t = 1:nIters

    %inicializar f(t)
    for j=1:nNodos     
        [p q] = size(Bj{j});
        sumVE{j} = zeros(n+1,1);
        for i=1:q
            sumVE{j} = sumVE{j} + (VE{j} + VE{Bj{j}(1,i)}); 
        end       
        EF{j} = 2.*alpha{j} - eta.*sumVE{j};
    end    
    
    for j=1:nNodos           
        %compute lambda(t+1) via (16)
        funcion=@(lambda)((-0.5)*(lambda'*Y_{j}*X_{j}*inv(U{j})*X_{j}'*Y_{j}*lambda)+(ones(nDatos,1)+Y_{j}*(X_{j}/U{j})*EF{j})'*lambda);
        lambda0 =zeros(nDatos,1);
        options = optimoptions(@fmincon,'Algorithm','sqp','Display','off');
        lb=zeros(nDatos,1);
        ub=ones(nDatos,1)*C*nNodos;       
        lambda{j}(:,1)=fmincon(funcion,lambda0,[],[],[],[],lb,ub,[],options);      
        %compute vj(t+1) via (17)
        VE{j}=(inv(U{j}))*(X_{j}'*Y_{j}*lambda{j}(:,1)-EF{j});  
    end

    %broadcast vj(t+1) to all neighborhoods i in bj
    for j=1:nNodos
        [p q] = size(Bj{j});
        sumVE{j} = zeros(n+1,1);
        for i=1:q
            sumVE{j} = sumVE{j} + (VE{j} + VE{Bj{j}(1,i)}); 
        end
        VE{j}=sumVE{j}/(2+length(Bj{j}));
        
    end
    %Compute alpha(t+1) via (18)
    for j=1:nNodos
        [p q] = size(Bj{j});
        sumVE2{j} = zeros(n+1,1);
        for i=1:q
                sumVE2{j} = sumVE2{j} + (VE{j}- VE{Bj{j}(1,i)}); 
        end   
        alpha{j}=alpha{j}+eta*0.5*sumVE2{j};
    end
    
    if t==10
        ve10=VE{1};
        ve20=VE{2};
        ve30=VE{3};
    end


end

graficar