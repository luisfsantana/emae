prl=mln;
for jj=1:npd-1
    ra=ra+10;
    tps=[prl(1) prl(round(end/2)) prl(end)];
    tps=tps-ten*(ct-tps)./abs(ct-tps);
    [prox,ii]=min(abs(tps(1)-Pts));tps(1)=Pts(ii);
    if par(ii)!=par(find(prl(1)==Pts))
        if isempty(find(prl(1)==pts)) prl(1)=pts(par(ii));end;
    end
    if tps(1)==prl(1) tps(1)=Pts(ii+1);end;
    
    [prox,ii]=min(abs(tps(3)-Pts));tps(3)=Pts(ii);
    if par(ii)!=par(find(prl(end)==Pts))
        if isempty(find(prl(end)==pts)) prl(end)=pts(par(ii));end;
    end
    if tps(3)==prl(end) tps(3)=Pts(ii+1);end;
    
    le=tps(1)-prl(1);
    dr=conj(prl(1)-ct);
    rs=roots([abs(le)^2 2*real(le*dr) abs(dr)^2-ra^2]);
    [prox,ii]=min(abs(rs));sl=rs(ii);
    
    re=tps(3)-prl(end);
    dr=conj(prl(end)-ct);
    rs=roots([abs(re)^2 2*real(re*dr) abs(dr)^2-ra^2]);
    [prox,ii]=min(abs(rs));sr=rs(ii);
    [prl,ct,ra]=sct(prl(1)+sl*le,tps(2),prl(end)+sr*re,t);
    
    clear m h;
    L=length(prl);
    for k=1:L
        [m(k),h(k)]=min(abs(prl(k)-Pts));
    end;
    [prox,k]=min(m(2:L-1));
    
    if (prox<m(1))&&(k<L/2)
        [pp,ii]=min(abs(prl(k+1)-Pts));
        prl=prl(k+1:end);
        prl(1)=Pts(ii);
    end;
    if (prox<m(L))&&(k>L/2)
        [pp,ii]=min(abs(prl(k+1)-Pts));
        prl=prl(1:k+1);
        prl(end)=Pts(ii);
    end;
    
    plot(prl+Zctr,'--go');
    
    for k=1:length(prl)-1
        vb=prl(k);va=prl(k+1);
        if abs(f(q,va,N,M)-f(q,vb,N,M))>abs(va-vb)*tg
            plot(prl(k)+Zctr,'--go','markerfacecolor','r');
            plot(prl(k+1)+Zctr,'--go','markerfacecolor','r');
        end;
    end;
end;
