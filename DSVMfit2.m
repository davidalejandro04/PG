function [VE,loss,eCost,consensus]=DSVMfit2(A,Adj,C,eta,noise,nItersParam,xTest,yTest)
test=false;
conv=0;
if nargin > 5
  nIters = nItersParam;
  if nargin > 6
      test=true;

else
  nIters = 100;
  conv=1;
end
  
eCost=0;

[~, nNodos]=size(A);
[~, f]=size(A{1});n=f-1;

for k = 1:nNodos
    Bj{k} = find(Adj(k,:),nNodos);
end

if(n==2)
   m=n+1;
else
   m=n;
end

PN1=zeros(m);PN1(m,m)=1;
lambda ={};

for j = 1:nNodos
    [nDatosi ~]=size(A{j});
    
    Y_{j} = diag(A{j}(:,3));
    if(n==2)
        X_{j} = [A{j}(:,1:n),ones(length(A{j}),1)]; 
    else
        X_{j} = [A{j}(:,1:n)]; 
    end        
    U{j} = (1+2*eta*sum(Adj(j,:))).*eye(m) - PN1;
    VE{j} = randn(m,1);  
    alpha{j} = randn(m,1);
    TE{j}=Y_{j}*X_{j}/(U{j})*X_{j}'*Y_{j};
    TE2{j}=Y_{j}*(X_{j}/U{j});
    XY{j}=X_{j}'*Y_{j};
end


if (test==true)
    loss=zeros(nIters,1);
    consensus=zeros(nIters,1);
    eCost=zeros(nIters,1);

end


for t = 1:nIters  
    %inicializar f(t)
    
    
    for j=1:nNodos     
        [p q] = size(Bj{j});
        sumVE{j} = zeros(m,1);
        for i=1:q
            sumVE{j} = sumVE{j} + (VE{j} + VE{Bj{j}(1,i)}+noise*normrnd(0,1)); 
            eCost(t)=eCost(t)+1;
        end       
        EF{j} = 2.*alpha{j} - eta.*sumVE{j};
    end    
    
    for j=1:nNodos      
        [nDatosi,~]=size(A{j});
    
        %compute lambda(t+1) via (16)
        funcion=@(lambda)((0.5.*lambda'*TE{j}*lambda)-((ones(nDatosi,1)+TE2{j}*EF{j})'*lambda));
        [nDatosi,~]=size(A{j});
        lambda0 =zeros(nDatosi,1);
        options = optimoptions(@fmincon,'Algorithm','interior-point','Display','off','MaxIterations',10000,'MaxFunctionEvaluations',10000);
        lb=zeros(nDatosi,1);
        ub=ones(nDatosi,1)*C*nNodos;   
        lambda{j}(:,1)=fmincon(funcion,lambda0,[],[],[],[],lb,ub,[],options);      
        %compute vj(t+1) via (17)
        VE{j}=(inv(U{j}))*(XY{j}*lambda{j}(:,1)-EF{j});
    end

    %broadcast vj(t+1) to all neighborhoods i in bj
    for j=1:nNodos
        [p q] = size(Bj{j});
        sumVE_{j} = VE{j};
        for i=1:q
            sumVE_{j} =  sumVE_{j}+(VE{Bj{j}(1,i)}+noise*normrnd(0,1)); 
            eCost(t)=eCost(t)+1;
        end
        VE{j}=sumVE_{j}/(1+length(Bj{j}));
    end
    
    %Compute alpha(t+1) via (18)
    for j=1:nNodos
        [p q] = size(Bj{j});
        sumVE2{j} = zeros(m,1);
        for i=1:q
                sumVE2{j} = sumVE2{j} + (VE{j}- VE{Bj{j}(1,i)}+noise*normrnd(0,1)); 
                eCost(t)=eCost(t)+1;
        end   
        alpha{j}=alpha{j}+eta*0.5*sumVE2{j};
    end
    
    Dist=(norm(VE{1}-VE{2})+norm(VE{3}-VE{2})+norm(VE{1}-VE{3}))/3;
    if (conv==1)
        if (Dist<0.001)
            break; 
            t
        end
    end
    t
end
eCost=cumsum(eCost);
end