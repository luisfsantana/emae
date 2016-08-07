% setenv: habilita comandos plot para <octave> no MAC OS X
setenv("GNUTERM","X11");

close all;
clear all;
more off;
format short;

ten = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              topografia.m                   %
% ENTRADA:                                    %
%   - curvas de nivel do terreno              %
%   - poligonal fechada correspondente ao     % 
%     talhao de plantio                       %
% SAIDA:                                      %       
%   - superficie polinomial 2D  que aproxima  %
%     a topografia do terreno no talhao       % 
%     de plantio                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
topografia; 
%
h = figure;set(h , 'Position' , [520 368 850 650]);
contour(x + Xctr , y + Yctr , z , nlc);
axis equal;
hold on;
plot([opts;opts(1)] + Zctr , 'k');
% epts: sao pontos extras para subdividir o talhao
%       de plantio no caso deste nao ser convexo
% se o poligono for convexo, entao lenght(epts) = 0,
% e portanto o comando <for> abaixo e' executado
% uma unica vez (p/ ek = 0)
for ek = 0:length(epts)/2
    % se ~isempty(epts) = true entao o poligono nao e' convexo  
    if ~isempty(epts) 
        clear pts;
        if 2*ek == length(epts) 
            pts = rsv;
        else
	    pts = [];
	    rsv = [];
            % produto vetorial
	    vec = conj(epts(2*ek + 2) - epts(2*ek + 1));
            for k = 1:length(Opts)
                temp = imag(vec*(Opts(k) - epts(2*ek + 1)));
		% regra da mao direita
                if temp >= 0 
		    pts = [pts;Opts(k)];
                end;
                if temp <= 0 
		    rsv = [rsv;Opts(k)];
                end;
            end
            clear Opts;
            Opts = rsv;
        end
    end
    
    % prox =  valor maximo assumido pelo polinomio 2D
    % ii   =  indice onde o maximo ocorre; se existem varios maximos,
    %         a funcao retorna o primeiro encontrado    
    [prox , ii] = max(f(q , pts , N , M)); % keyboard();
    pts = [pts(ii:end); pts(1:ii)];
  
    clear Pts;
  
    par = 1;
    Pts = pts(1);
    for k = 1:length(pts) - 1
        vec = pts(k + 1) - pts(k);
        stp = abs(vec);
        if stp > 10
            dvs = ceil(stp/10);
            vec = vec/dvs;
            for K = 1:dvs
                par = [par , k];
                Pts = [Pts;pts(k) + K*vec];
            end
        else
            par = [par , k];
            Pts = [Pts;pts(k)];
        end
    end
  
    for k = 1:length(Pts)
        [m(k) , h(k)] = max(abs(Pts(k) - Pts));
    end;
    [Mm , k] = max(m);
    mp = (Pts(h(k)) + Pts(k))/2;
    zp = f(q , mp , N , M);
    zc = f(q , Pts , N , M);
    ra = 0;
    de = 2;
    npd = 0;
    npu = 0;
    nbf = 999;
    naf = 999;
    d = 1;
    jump = -1;
    t = [0:.05:1];
  
    while (((ra - npu*ten)<50)||(naf <= nbf)) && (de > 0.25) && jump
        jump = jump - 1;
        nbf = naf;
        de = de/2;
        for j = 1:4
	    % zc ~ zp + de
            [zs , J(j)] = min(abs(zc - zp - de));
            fpts(j) = zc(J(j));
            zc(J(j)) = 1000;
        end
        zc(J) = fpts;
        clear h j m;
        for j = 1:4
            [m(j) , h(j)] = max(abs(Pts(J(j)) - Pts(J)));
        end;
        [Mm , j] = max(m);
        vec = mp - Pts(J(h(j)));
        mln = Pts(J(h(j))) + t*vec;
        vec = Pts(J(j)) - mp;
        mln = [mln(1:end - 1) mp + t*vec];
    
        if real(mln(1)) > real(mln(end)) 
            mln = mln(end:-1:1);
        end;
        cs1 = real((Pts(1) - mp)*conj(mln(1) - mp)/abs((Pts(1) - mp)*(mln(1) - mp)));
        cs2 = real((Pts(1) - mp)*conj(mln(end) - mp)/abs((Pts(1) - mp)*(mln(end) - mp)));
        if acos(cs1) + acos(cs2) >= pi 
            de = 4*de;
            jump = 1;
        elseif isempty(epts)
	    % sct desenha arcos de circunferencias
            [mln , ct , ra] = sct(mln(1) , mp , mln(end) , t);
            npu = floor((ra - min(abs(Pts - ct)))/10);
            npd = floor((max(abs(Pts - ct)) - ra)/10);
            naf = npu + npd;
        else
            ml;
            break;
        end
    end
 
    cst = ['r' 'g' 'b' 'm' 'c'];
    ccl = 2;
    plot(mln + Zctr , '--ko' , 'markerfacecolor' , cst(ccl) , 'markersize' , 5);
    ct_orig = ct;
    ra_orig = ra;
    % criterio da imposição maxima de  5% de declividade
    tg = tan(5*pi/180);
    for k = 1:length(mln) - 1
        vb = mln(k);
	va = mln(k + 1);
        if abs(f(q , va , N , M) - f(q , vb , N , M)) > abs(va - vb)*tg 
            disp('Angle NOT ok');
            k
        end
    end
    % o procedimento dpl.m desenha as paralelas para baixo
    dpl; 
    ra = ra_orig;
    % o procedimento upl.m desenha as paralelas para cima
    upl; 
    axis equal;
end

% se o poligono que representa o talhao não for convexo
% o codigo abaixo oferece a possibilidade do usuario armazenar
% a subdvisao do poligono nas suas partes convexas que
% produzem resultado satisfatorio
if sv && (fid == -1) && (~isempty(epts))
    fprintf('***************************************************************************\n');
    fprintf('   5) deseja armazenar pontos da subdivisao num arquivo para uso futuro?  *\n');
    fprintf('                            Sim = 1    Nao = 0                            *\n');
    fprintf('***************************************************************************\n');

    ok = 0;
    while ~ok
        chc = input(' ');
        if chc == 1
            L = length(Epts);
            lis = [real(Epts) , imag(Epts)];
            save(arq , 'lis' , '-ascii');
            ok = 1;
            clear lis;
        elseif isempty(chc)||(chc~=0)
            disp('Please answer 1, 0 or interrupt with Ctrl-C.');
        else
            ok = 1;
        end;
    end
end


