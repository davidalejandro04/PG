function[fj]=funcion(alpha,eta,vj,v)
    suma=0;
    for i=1:n      
        suma=suma+(vj-v(i));
    end
    fj=2*alpha-eta*suma;
end
