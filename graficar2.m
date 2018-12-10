figure
    G=graph(Adj)
    plot(G,'-.dr','Layout','circle')
    xticklabels({''})
    yticklabels({''})
    title('Red de prueba')
saveas(gcf,'conexión.png')

figure

for i=1:6
plot(A{i}(find(A{i}(:,3)==1),1),A{i}(find(A{i}(:,3)==1),2),'o','color','b')
hold on

plot(A{i}(find(A{i}(:,3)==-1),1),A{i}(find(A{i}(:,3)==-1),2),'+','color','r')

hold on 
end


xlabel('x_1','Interpreter','tex' )
ylabel('x_2','Interpreter','tex' )

m1=-VE{1}(1)/VE{1}(2);
b1=VE{1}(3)
h1=refline(m1,b1)

m2=-VE{1}(1)/VE{1}(2);
b2=VE{1}(3)
h2=refline(m2,b2)

m3=-VE{1}(1)/VE{1}(2);
b3=VE{1}(3)
h3=refline(m3,b3)


title('SVM Final','Interpreter','tex' )
saveas(gcf,'trainDatos.png')
