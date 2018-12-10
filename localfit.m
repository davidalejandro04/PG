



%Inicializar Matrices, VE y alpha como aleatorios, definir PN1
[Y_,X_,U,lambda,PN1]=init(A,Adj,eta);
Y1=diag(Y_{1})
X1=X_{1}(1:nDatos,1:2)

Y2=diag(Y_{2})
X2=X_{2}(1:nDatos,1:2)

Y3=diag(Y_{3})
X3=X_{3}(1:nDatos,1:2)


SVMModel1=fitcsvm(X1,Y1)
SVMModel2=fitcsvm(X2,Y2)
SVMModel3=fitcsvm(X3,Y3)




figure

for i=1:3
plot(A{i}(1:nDatos1,1),A{i}(1:nDatos1,2),'o','color','b')
hold on
plot(A{i}(nDatos2+1:nDatos,1),A{i}(nDatos2+1:nDatos,2),'+','color','r')
hold on 
end
 
h1=refline(-SVMModel.Beta(2)/SVMModel1.Beta(1),SVMModel1.Bias)
h2=refline(-SVMModel.Beta(2)/SVMModel2.Beta(1),SVMModel2.Bias)
h3=refline(-SVMModel.Beta(2)/SVMModel3.Beta(1),SVMModel3.Bias)
hold on


