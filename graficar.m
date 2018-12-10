[Y_,X_,U,lambda,PN1]=init(A,Adj,eta);

Y1=diag(Y_{1})
X1=X_{1}(1:nDatos,1:2)

Y2=diag(Y_{2})
X2=X_{2}(1:nDatos,1:2)

Y3=diag(Y_{3})
X3=X_{3}(1:nDatos,1:2)

Y4=diag(Y_{4})
X4=X_{4}(1:nDatos,1:2)


figure
    G=graph(Adj)
    plot(G,'-.dr','Layout','circle')
    xticklabels({''})
    yticklabels({''})
    title('Red de prueba')
saveas(gcf,'Red.png')



figure

for i=1:3
plot(A{i}(find(A{i}(:,3)==1),1),A{i}(find(A{i}(:,3)==1),2),'o','color','b')
hold on

plot(A{i}(find(A{i}(:,3)==-1),1),A{i}(find(A{i}(:,3)==-1),2),'+','color','r')

hold on 
end
xlabel('x_1','Interpreter','tex' )
ylabel('x_2','Interpreter','tex' )
%plotLocal
title('SVM Final','Interpreter','tex' )
legend
saveas(gcf,'G3.png')
