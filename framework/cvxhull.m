mx=min(real(Pts));
Pts=Pts-mx;
[my,ii]=max(imag(Pts.*(real(Pts)==0)));
Pts=Pts-i*my;
k=1;
ok=1;
while ok
    temp=Pts(k);
    Pts(k)=Pts(ii);
    Pts(ii)=temp;
    if k==3
        Pts(end+1)=Pts(1);
    end;
    ag=min(angle(Pts(k+1:end)));
    [md,ii]=max(abs(Pts(k+1:end).*(angle(Pts(k+1:end))==ag)));
    ii=ii+k;
    if Pts(ii)~=Pts(1)
        ang(k)=pi/2+ag;
        Pts=Pts./exp(i*ang(k));
        pos(k)=Pts(ii);
        Pts=Pts-pos(k);
        k=k+1;
    else
        ok=0;k=k-1;
    end;
end;

for h=k:-1:1
    Pts=Pts+pos(h);
    Pts=Pts.*exp(i*ang(h));
end;
Pts=Pts+mx+i*my;
for h=1:k
end;
