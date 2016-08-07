prl=nml;
npd=floor((max(abs(Pts-ct(1)))-ra(1))/40);
for jj=1:npd
    ra=ra+ten*sg;
    tps(1)=prl(1);
    if jj==1
        for kk=1:length(ct)-1 tps(kk+1)=prl(kk*T);
        end;
    end
    for kk=1:length(ct)
        tps(kk)=tps(kk)-ten*sg(kk)*(ct(kk)-tps(kk))./abs(ct(kk)-tps(kk));
    end
    rt=prl(end);
    tps(kk+1)=rt-ten*sg(end).*(ct(end)-rt)./abs(ct(end)-rt);
    [prox,ii]=min(abs(tps(1)-Pts));tps(1)=Pts(ii);
    if par(ii)!=par(find(prl(1)==Pts))
        if isempty(find(prl(1)==pts))
            prl(1)=pts(par(ii));
        end;
    end
    if tps(1)==prl(1)
        tps(1)=Pts(ii+1);
    end;
    
    [prox,ii]=min(abs(tps(end)-Pts));
    tps(end)=Pts(ii);
    if par(ii)!=par(find(prl(end)==Pts))
        if isempty(find(prl(end)==pts))
            prl(end)=pts(par(ii));
        end;
    end
    if tps(end)==prl(end)
        tps(end)=Pts(ii+1);
    end;
    
    le=tps(1)-prl(1);
    dr=conj(prl(1)-ct(1));
    rs=roots([abs(le)^2 2*real(le*dr) abs(dr)^2-ra(1)^2]);
    [prox,ii]=min(abs(rs));
    sl=rs(ii);
    
    re=tps(end)-prl(end);
    dr=conj(prl(end)-ct(end));
    rs=roots([abs(re)^2 2*real(re*dr) abs(dr)^2-ra(end)^2]);
    [prox,ii]=min(abs(rs));sr=rs(ii);
    
    lt=prl(1);
    rt=prl(end);
    clear prl;
    vtr=lt+sl*le-ct(1);
    tht=angle(vtr)-angle(tps(2)-ct(1));
    prl=ct(1)+vtr*exp(tht*t/i);
    for kk=2:length(ct)-1
        vtr=tps(kk)-ct(kk);
        tht=angle(vtr)-angle(tps(kk+1)-ct(kk));
        prl(end+1:end+T)=ct(kk)+vtr*exp(tht*t/i);
    end
    vtr=tps(end-1)-ct(end);
    tht=angle(vtr)-angle(rt+sr*re-ct(end));
    prl(end+1:end+T)=ct(end)+vtr*exp(tht*t/i);
    
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
