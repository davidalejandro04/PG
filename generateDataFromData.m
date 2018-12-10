function [A,xTest,yTest] =generateDataFromData(X,Y,nNodos)

Y(find(Y~=1))=-1;
[trainInd,~,testInd] = dividerand(length(X),0.7,0,0.3)

xTest=X(testInd,:);
yTest=Y(testInd,:);
X=X(trainInd,:);

cant=round(length(X)/nNodos);

last=length(X)

for j=0:nNodos-2
    x=[X(cant*(j)+1:(cant)*(j+1),:)];y=[Y(cant*(j)+1:(cant)*(j+1))]';
    A{j+1} = [ x y'];  
    
end

x=[X(cant*(nNodos-1)+1:last,:)];y=[Y(cant*(nNodos-1)+1:last,:)];
A{nNodos} = [ x y];  
    
end
