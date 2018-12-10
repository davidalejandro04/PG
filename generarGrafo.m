n=10 ; % number of nodes in the graph
density = 4/10; % a rough estimate of the amount of edges       
A = sprand( n, n, density ); % generate adjacency matrix at random
% normalize weights to sum to num of edges
A = tril( A, -1 );    
A = spfun( @(x) x./nnz(A), A );    
% make it symmetric (for undirected graph)
A = A + A.';
A(A~=0)=1;
    
G=graph(A)
plot(G)