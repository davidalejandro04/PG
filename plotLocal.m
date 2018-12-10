
SVMModel1=fitcsvm(X1,Y1)
SVMModel2=fitcsvm(X2,Y2)
SVMModel3=fitcsvm(X3,Y3)
h11=refline(-SVMModel1.Beta(2)/SVMModel1.Beta(1),SVMModel1.Bias)
h11.Color='k'
h11.LineStyle='--';
hold on
h21=refline(-SVMModel2.Beta(2)/SVMModel2.Beta(1),SVMModel2.Bias)
h21.Color='k'
h21.LineStyle='--';
hold on
h31=refline(-SVMModel3.Beta(2)/SVMModel3.Beta(1),SVMModel3.Bias)
h31.Color='k'
h31.LineStyle='--';
hold on
