function [wx,wy]=g(q,Z,N,M)
x=real(Z);y=imag(Z);
wx=0;wy=0;
for I=1:N-1
    for J=1:M-1
        wx=wx+q(I,J)*(M-J)*x.^(M-J-1).*y.^(N-I);
        wy=wy+q(I,J)*(N-I)*x.^(M-J).*y.^(N-I-1);
    end;
end;

for J=1:M-1
    wx=wx+q(N,J)*(M-J)*x.^(M-J-1);
end
for
    I=1:N-1 wy=wy+q(I,M)*(N-I)*y.^(N-I-1);
end
