%figure
%plot(r)

%[VE,ve10,ve20,ve30,ve1,ve2,ve3,r]=DSVMfit(A,Adj,eta,nIters,20/nNodos,xTest,yTest)

% 
% [VE,ve10,ve20,ve30,r]=DSVMfit(A,Adj,eta,nIters,20/nNodos,xTest,yTest)
% [VE,ve10,ve20,ve30,r2]=DSVMfit(A,Adj,eta,nIters,60/nNodos,xTest,yTest)
% [VE,ve10,ve20,ve30,r3]=DSVMfit(A,Adj,eta,nIters,40/nNodos,xTest,yTest)
% [VE,ve10,ve20,ve30,r4]=DSVMfit(A,Adj,eta,nIters,100/nNodos,xTest,yTest)
% 
% r=r/(nNodos*nDatosTest);
% r2=r2/(nNodos*nDatosTest);
% r3=r3/(nNodos*nDatosTest);
% r4=r4/(nNodos*nDatosTest);
% 
% figure
% plot(r);hold on
% plot(r2);hold on;
% plot(r3);hold on;
% plot(r4);hold on;
% legend({'$\mathcal{JC}=20$','$\mathcal{JC}=60$','$\mathcal{JC}=40$','$\mathcal{JC}=100$'},'Interpreter','latex')
% title('$\textbf{R}_{emp}(t)$','Interpreter','latex')
% xlabel('Iteración t','Interpreter','latex')
% ylabel('$\textbf{R}_{emp}$','Interpreter','latex')
% saveas(gcf,'ErrorFullyConnected.png')