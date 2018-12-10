function [A,xTest,yTest] =generateData3D(nNodos,nDatos1,nDatos2,nDatosTest,n)
%n: numero de features; 
%Adj: Matriz adjunta del grafo de la conexión
%nDatos1: Número de datos clase 1
%nDatos2: Número de datos clase 2


mu = [0,0,0];
mu2=[2, -2, 2];

mu2=-mu2;

sigma= [1,0,0;0,1,0;0,0,1];
sigma2= [1,0,0;0,1,0;0,0,1];


for j=1:nNodos
    sprev = rng(0,'v5uniform');
    rng(sprev);
    X_1 = mvnrnd(mu,sigma,nDatos1);
    X_2 = mvnrnd(mu2,sigma2,nDatos2);


    x=[X_1;X_2]';y=[ones(1,nDatos1) -ones(1,nDatos2)];
    size(x)
    size(y)
    x=[x',ones(length(x),1)]';
    A{j} = [ x', y'];  
    
end

sprev = rng(0,'v5uniform');
rng(sprev);

X_1test = mvnrnd(mu,sigma,nDatosTest);
X_2test = mvnrnd(mu2,sigma2,nDatosTest);
xTest=[X_1test;X_2test]';yTest=[ones(1,nDatosTest) -ones(1,nDatosTest)];
xTest=[xTest',ones(length(xTest),1)];
end
