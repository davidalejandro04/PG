
for i=1:3
plot(A{i}(find(A{i}(:,5)==1),1),A{i}(find(A{i}(:,5)==1),3),'o','color','b')
hold on

plot(A{i}(find(A{i}(:,5)==-1),1),A{i}(find(A{i}(:,5)==-1),3),'+','color','r')

hold on 
end


m1=-VE{1}(1)/VE{1}(2);
b1=VE{1}(4)
h1=refline(m1,b1)

m2=-VE{2}(1)/VE{2}(2);
b2=VE{2}(4)
h2=refline(m2,b2)

m3=-VE{3}(1)/VE{3}(2);
b3=VE{3}(4)
h3=refline(m3,b3)

