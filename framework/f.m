function w=f(q,Z,N,M)
x=real(Z);y=imag(Z);
w=0;
for I=1:N
    for J=1:M
        w=w+q(I,J)*x.^(M-J).*y.^(N-I);
    end;
end;