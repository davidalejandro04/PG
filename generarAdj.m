function [Adj]=generarAdj(nNodos)
Adj = randi([0 1],nNodos);
for i=1:nNodos
	for j=1:nNodos
		if i==j Adj(i,j)=0;end
	end
end
