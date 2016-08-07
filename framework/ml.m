if ek==0
    fin=mln(end);
    prt=[mln(1);ekns;fin];
    mln=[];ct=[];ra=[];sg=1;
    ctp=(prt(1)+prt(2))/2+2*i*(prt(2)-prt(1));
    ctm=(prt(1)+prt(2))/2-2*i*(prt(2)-prt(1));
    if max(abs(Pts-ctp))-min(abs(Pts-ctp))>max(abs(Pts-ctm))-min(abs(Pts-ctm)) ct=ctm;sg=-1;
    else ct=ctp;end;
    chg=0;
    ptp=prt(2)+0.05*(epts(2)-epts(1));
    ptm=prt(2)-0.05*(epts(2)-epts(1));
    ctp=(prt(1)+ptp)/2+2*i*sg*(ptp-prt(1));
    ctm=(prt(1)+ptm)/2+2*i*sg*(ptm-prt(1));
    if max(abs(Pts-ctp))-min(abs(Pts-ctp))<max(abs(Pts-ct))-min(abs(Pts-ct))
        prt(2)=ptp;ct=ctp;sg= 1;chg=1;
    end;
    if max(abs(Pts-ctm))-min(abs(Pts-ctm))<max(abs(Pts-ct))-min(abs(Pts-ct))
        prt(2)=ptm;ct=ctm;sg=-1;chg=1;
    end;
    while chg
        pt=prt(2)+0.05*sg*(epts(2)-epts(1));
        rc=(prt(1)+pt)/2+2*i*sg*(pt-prt(1));
        if max(abs(Pts-rc))-min(abs(Pts-rc))<max(abs(Pts-ct))-min(abs(Pts-ct))
            prt(2)=pt;ct=rc;
        else chg=0;end;
    end
elseif ek<length(epts)/2
    temp=prt(2:end);
    clear prt;
    prt=temp;
    ev=conj(prt(2)-prt(1));
    vm=abs(ev);ev=ev/vm;
    dv=prt(1)-ct;dv=dv/abs(dv);
    ra=vm/2/real(dv*ev);
    ct=prt(1)+ra*dv;
else
    [prox,ii]=min(abs(f(q,prt(2),N,M)-f(q,Opts,N,M)));
    fin=Opts(ii);
    temp=[prt(2);fin];
    clear prt;
    prt=temp;
    ev=conj(prt(2)-prt(1));
    vm=abs(ev);ev=ev/vm;
    dv=prt(1)-ct;dv=dv/abs(dv);
    ra=vm/2/real(dv*ev);
    ct=prt(1)+ra*dv;
end
vtr=prt(1)-ct;
ra=abs(vtr);
tht=angle(vtr)-angle(prt(2)-ct);
arc=ct+vtr*exp(tht*t/i);
clear mln;
mln=arc;
npu=floor((ra-min(abs(Pts-ct)))/10);
npd=floor((max(abs(Pts-ct))-ra)/10);
naf=npu+npd;


