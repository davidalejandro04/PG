figure
nNodos=3;
mu = [6 3];
mu2=[-2 2];

sigma2 = [1 0; 0 2];
sigma= [1 0; 0 2];
nDatos1=20;
nDatos2=20;
n=1;



nDatos=nDatos1+nDatos2;

for j=1:nNodos
    sprev = rng(0,'v5uniform');
    rng(sprev);
    X_1 = mvnrnd(mu,sigma,nDatos1);
    X_2 = mvnrnd(mu2,sigma2,nDatos2);

    x=[X_1;X_2]';y=[ones(1,nDatos1) -ones(1,nDatos2)];
    A{j} = [ -((ones(n,1)*y).*x)' -y'];

end

for j=1:nNodos
    plot(A{j}(1:nDatos1,2),A{1}(1:nDatos1,1),'+','color',[(1-0.25*j) 0 0])
    hold on
    plot(A{j}(nDatos2:nDatos,2),A{1}(nDatos2:nDatos,1),'o','color',[0 0 (1-0.25*j)])
    hold on
end

