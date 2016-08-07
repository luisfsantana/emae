disp('Please adjust terminal window to show full picture.');
disp('Give a topography to open. Programme terminates when not found.');
fnm=input(' ','s');fid=-1;
arq=strcat(fnm,'.txt');
fid=fopen(arq,'rt');

if isempty(fnm)||(fid==-1) return;end;

lis=textread(strcat(arq));
fclose(fid);fac=1;
if (max(lis)-min(lis))>10^7 fac=100;end;
lis=lis/fac;
Lis=[lis(1:3:end) lis(2:3:end) lis(3:3:end)];
X=Lis(:,1)';
Y=Lis(:,2)';
Z=Lis(:,3)';%'
Z(end+1)=-1;
VN=[];
Cnt=1;cnt=1;
nlc=0;
h=figure;set(h,'Position',[650 300 560 420]);
hold on;
while Cnt<length(X)
 do cnt=cnt+1;until Z(cnt-1)!=Z(cnt);
 VN=[VN Z(cnt-1)];
 plot(X(Cnt:cnt-1)+i*Y(Cnt:cnt-1),'-o');drawnow;
 Cnt=cnt;nlc=nlc+1;
end
axis equal;
grid('minor');

disp('Give a plot to open. Programme terminates when not found.');
fnm=input(' ','s');fid=-1;
arq=strcat(fnm,'.txt');
fid=fopen(arq,'rt');

if isempty(fnm)||(fid==-1) return;end;

lis=textread(strcat(arq));
fclose(fid);
lis=lis/fac;
pts=lis(1:2:end)+i*lis(2:2:end);
clear lis;
if pts(1)==pts(end) pts=pts(1:end-1);end;
ll=length(pts);
for k=1:ll
 plot(real(pts(k)),imag(pts(k)),'rs'); 
end;
plot([pts;pts(1)],'k');
axis equal;

Xmin=min(X);Xmax=max(X);
Ymin=min(Y);Ymax=max(Y);
ex=linspace(Xmin,Xmax,round((Xmax-Xmin)/10));
wy=linspace(Ymin,Ymax,round((Ymax-Ymin)/10));
M=length(ex);
N=length(wy);
[x,y]=meshgrid(ex,wy);z=0*x;
for i=1:N
 for j=1:M
  [pr,k]=min(abs(x(i,j)-X)+abs(y(i,j)-Y));
  z(i,j)=Z(k);
 end;
end;

h=figure;set(h,'Position',[700 350 560 420]);
surf(x,y,z);

clear x;clear y;clear i;
clear X;clear Y;clear Z;
n=floor(N/4);m=floor(M/4);
Z=z(1:n:N,1:m:M);
Z(end,:)=z(end,1:m:M);
Z(:,end)=z(1:n:N,end);
M=length(Z(1,:));
N=length(Z(:,1));
Xctr=(Xmax+Xmin)/2;
Yctr=(Ymax+Ymin)/2;
Zctr=Xctr+i*Yctr;
X=linspace(Xmin,Xmax,M)-Xctr;
Y=linspace(Ymin,Ymax,N)-Yctr;
Xmin=X(1);Xmax=X(end);
Ymin=Y(1);Ymax=Y(end);
[x,y]=meshgrid(X,Y);
p=zeros(N,M);
for i=1:N
 p(i,:)=polyfit(x(i,:),Z(i,:),M-1);
end
q=zeros(N,M);
for j=1:M
 q(:,j)=polyfit(y(:,j),p(:,j),N-1);
end
clear p;clear i;
clear X;clear Y;
clear x;clear y;
X=linspace(Xmin,Xmax,4*(M-1)+1);
Y=linspace(Ymin,Ymax,4*(N-1)+1);
[x,y]=meshgrid(X,Y);
z=f(q,x+i*y,N,M);

h=figure;set(h,'Position',[650 300 560 420]);
surf(x+Xctr,y+Yctr,z);

[C,LEV]=contourc(x,y,z,VN);
h=figure;set(h,'Position',[520 368 850 650]);
hold on;
contour(x+Xctr,y+Yctr,z,nlc);
grid('minor');
Pts=pts;
cvxhull;
opts=pts-Zctr;
pts=Pts(1:k+1)-Zctr;
hold on;
plot([opts;opts(1)]+Zctr,'k');
plot([pts;pts(1)]+Zctr,'k');plot(pts+Zctr,'rs');
axis equal;

epts=[];ekns=[];
fid=-1;
arq=strcat('e',arq);
fid=fopen(arq,'rt');

sv=0;
if length(opts)>length(pts)
 if fid==-1
  sv=1;
  disp('Choose points with the left button to subdivide the plot.');
  disp('Conclude with the right button.');
  k=1;
  prox=3;
  ok=0;
  button=10;
  while button~=3
   [aa,bb,button]=ginput(1);
   if button~=3
    epts(k)=aa+i*bb;
    plot(epts(k),'--gs','markerfacecolor','b');
    ok=1;
   else ok=0;end;
   if ok k=k+1;end;
  end;
  epts=epts.';%'
  Epts=epts;
 else
  lis=textread(arq);
  fclose(fid);
  lis=lis;
  epts=lis(1:2:end)+i*lis(2:2:end);
  clear lis;
 end;
end;

if ~isempty(epts)
 epts=epts-Zctr;
 par=1;
 Opts=opts(1);
 for k=1:length(opts)-1
  vec=opts(k+1)-opts(k);
  stp=abs(vec);
  if stp>10
   dvs=ceil(stp/10);
   vec=vec/dvs;
   for K=1:dvs
    par=[par,k];
    Opts=[Opts;opts(k)+K*vec];
   end
  end
 end
 eL=length(epts);
 for k=1:eL
  [prox,ii]=min(abs(epts(k)-Opts));
  epts(k)=Opts(ii);
 end
 for k=1:eL/2 
  ekns=[ekns;(epts(2*k-1)+epts(2*k))/2];
 end 
end
