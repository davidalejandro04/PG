%main

clear all
close all
nIters=80;
set(0,'defaultTextInterpreter','latex');
%load('grafo6.mat');
%Adj=A;
%clear A, n;
%%Generar Grafo

Adj=[0,1,0;1,0,1;0,1,0];
%Adj=[0,1,1;1,0,1;1,1,0];
%Adj=[0,1,0,0,0,0; 1,0,1,0,0,0; 0,1,0,1,0,0; 0,0,1,0,1,0;  0,0,0,1,0,1;0,0,0,0,1,0]; %Lazo

%Adj=[0,1,1,1,1,1; 1,0,0,0,0,0; 1,0,0,0,0,0; 1,0,0,0,0,0; 1,0,0,0,0,0;1,0,0,0,0,0]; %Central

%Adj=[0,1,1,1,1,1; 1,0,1,0,0,0; 1,1,0,1,0,0;1,0,1,0,1,0;1,0,0,1,0,1;1,0,0,0,1,0]; %Central interconectada

%Adj=[0,0,0,1,1,1; 0,0,0,1,1,1; 0,0,0,1,1,1; 1,1,1,0,0,0; 1,1,1,0,0,0;1,1,1,0,0,0]; %Mesh

%Adj=[0,1,1,1,1,1; 1,0,1,1,1,1; 1,1,0,1,1,1; 1,1,1,0,1,1; 1,1,1,1,0,1;1,1,1,1,1,0]; %Fully connected

%Adj=[0,1,0,0,0,0; 1,0,1,0,0,0; 0,1,1,1,1,0; 0,0,1,0,1,1;0,0,1,1,1,0;0,0,0,1,0,0]; %Self loops

[nNodos nCols] = size(Adj);

%Parámetros del modelo
G=graph(Adj);
C=60/nNodos;    
eta=10;
noise=0.1;

%Generar Datos
nFeatures=2;
nDatos1=10;
nDatos2=10;
nDatos=nDatos1+nDatos2;
nDatosTest=100;



%A: Datos de entrenamiento. T: Datos de test

%[A,xTest,yTest]=generateData3D(nNodos,nDatos1,nDatos2,nDatosTest,nFeatures);

[A,xTest,yTest]=generateData(nNodos,nDatos1,nDatos2,nDatosTest,nFeatures);
%De otros datos:X,Y %
%load('cleveland.mat')
%[A,xTest,yTest]=generateDataFromData(X,Y,nNodos);

profile on
[VE,loss,eCost,consensus]=DSVMfit(A,Adj,C,eta,noise,nIters,xTest,yTest);

profile off
profsave

%%Datos que son relevantes para métricas:

%Error respecto a VEdado
VEdado=[-1.0607,-1.2177,2.6077];


L=laplacian(G);
D=eig(L)

algConectivity=D(2)
ucc = centrality(G,'closeness');
udd = centrality(G,'degree');
ubb = centrality(G,'betweenness');
avucc=mean(ucc);
avudd=mean(udd);
avubb=mean(ubb);

g1=[A{1}(:,1:2),ones(length(A{1}),1)];
g2=[A{2}(:,1:2),ones(length(A{2}),1)];
g3=[A{3}(:,1:2),ones(length(A{3}),1)];



figure
semilogy(consensus)
title('Error de consenso')
ylabel('Error')
xlabel('Iteracion')
saveas(gcf,'cons.png')

figure
plot(0.5*(loss/(nDatos*nNodos*6)))
title('$\textbf{R}_{Test}$ vs Iteracion')
ylabel('$\textbf{R}_{Test}$')
xlabel('Iteracion')
saveas(gcf,'loss.png')

graficar2

filename = 'test6Nodos.mat';
save(filename)

cons=0;
n=0;
for i=1:6
    for j=1:6
        if i~=j
            cons=cons+norm(VE{i}-VE{j});
            n=n+1;
        end
    end
end
cons=cons/n
