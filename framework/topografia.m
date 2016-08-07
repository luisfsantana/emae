% keyboard(); % type return at debug> option to run
% no need to add semicolon to end -> end; ???
fprintf('***************************************************************************\n');
fprintf('Por favor, ajuste a tela do terminal para exibir avisos sem quebras       *\n');
fprintf('   1) digite nome do arquivo contendo curvas de nivel do terreno          *\n');
fprintf('(o programa termina se arquivo nao for encontrado)                        *\n');
fprintf('***************************************************************************\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENTRADA: CURVAS DE NIVEL DO TERRENO       %
%          FORNECIDAS POR ARQUIVO TEXTO     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fnm = input(' ','s');
fid = -1;
arq = strcat(fnm,'.txt');
fid = fopen(arq,'rt');
if isempty(fnm)||(fid == -1)
    return;
end
% conversao do arquivo texto para o vetor lis[]
lis = textread(strcat(arq));
fclose(fid);
% fac <-- fator de escala do vetor lis[]
fac = 1;
if (max(lis) - min(lis))>10^7
    fac = 100;
end
lis = lis/fac;
% conversao do vetor lis[] na matrix Lis[X,Y,Z] onde
% (X,Y) <-- coordenadas e  Z(X,Y) <-- altura
% das curvas de nivel
Lis = [lis(1:3:end) lis(2:3:end) lis(3:3:end)];
% transposicao de coluna para linha: X,Y,Z sao colunas
X = Lis( : ,1)';
Y = Lis( : ,2)';
Z = Lis( : ,3)';
Z(end + 1) = -1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% desenho das curvas de nivel da "FIGURE 1" %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VN  <-- alturas das curvas de nivel (monotona)
VN = [];
% Cnt <-- quantidade de pontos com a mesma altura
Cnt = 1;
% cnt <-- quantidade acumulada de pontos com a mesma altura
cnt = 1;
% nlc <-- quantidade de curvas de nivel
nlc = 0;
h = figure;
set(h,'Position',[650 300 560 420]);
hold on;
while Cnt<length(X)
    do
    cnt = cnt + 1;
    until Z(cnt - 1) != Z(cnt);
    % cnt - 1 = quantidade de pontos com a mesma altura
    VN = [VN Z(cnt - 1)];
    % desenha poligonal com (cnt-Cnt-1) segmentos cujos vertices sao
    %        X(t) + iY(t),   t = Cnt, ... ,cnt-1
    plot(X(Cnt : cnt - 1) + i*Y(Cnt : cnt - 1),'-o');
    drawnow;
    Cnt = cnt;
    nlc = nlc + 1;
end
axis equal;
grid('minor');
%          FIM DA "Figure 1"                %
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENTRADA: POLIGONAL FECHADA FORNECIDA POR  %
%          ARQUIVO TEXTO QUE REPRESENTA O   %
%          TALHAO DE PLANTIO                %
% PROCESSAMENTO:                            %
%          Conversao p/ vetor complexo pts  %
%          Grafico                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('***************************************************************************\n');
fprintf('   2) digite nome do arquivo representando poligono do talhao de plantio  *\n');
fprintf('(o programa termina se arquivo nao for encontrado)                        *\n');
fprintf('***************************************************************************\n');
fnm = input(' ','s');
fid = -1;
arq = strcat(fnm,'.txt');
fid = fopen(arq,'rt');
if isempty(fnm)||(fid == -1)
    return;
end
% conversao do arquivo .txt p/ o vetor lis[] contendo as coordenadas
%         X=lis(1:2:end)  e   Y=lis(2:2:end)
lis = textread(strcat(arq));
fclose(fid);
% lis[] escalonado convenientemente por fac
lis = lis/fac;
% vertices do poligono em coordenadas complexas
pts = lis(1:2:end) + i*lis(2:2:end);
clear lis;
% se o poligono for fechado entao retira a repeticao
if pts(1) == pts(end)
    pts = pts(1 : end - 1);
end
% imprime os vertices da poligonal representando-os
% por quadrados vermelhos ('rs')
ll = length(pts);
for k = 1 : ll
    plot(real(pts(k)),imag(pts(k)),'rs');
end
% imprime a poligonal conectando o ultimo com o 1º ponto de pts
% o parametro ('k') corresponde 'a cor preta
plot([pts;pts(1)],'k');
axis equal;
%          FIM DA "Figure 1"                 %
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTRUCAO DE UMA FUNCAO POLINOMIAL 2D QUE %
% APROXIMA A TOPOGRAFIA DO TALHAO DE PLANTIO %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xmin=min(X);
Xmax=max(X);
Ymin=min(Y);
Ymax=max(Y);
% ex = vetor com round((Xmax-Xmin)/10) pontos,
%      linearmente espacados entre Xmin e Xmax
%      satisfazendo aproximadamente a condicao
%                 ex(j)-ex(j-1) = ten
ex=linspace(Xmin,Xmax,round((Xmax-Xmin)/10));
% idem para wy
wy=linspace(Ymin,Ymax,round((Ymax-Ymin)/10));
M=length(ex);
N=length(wy);
% meshgrid(ex,wy) replica a particao de vetores ex e wy
%          para produzir um reticulado completo [x,y]
[x,y] = meshgrid(ex,wy);
% inicializacao das alturas no reticulado [x,y]
z = 0*x;
for i = 1 : N  % i torna-se inteira
    for j = 1 : M
        % para cada (i,j), determina a menor distancia (pr) entre
        %         (x(i,j),y(i,j)) e  (X(k),Y(k))
        % e determina um indice k onde tal minimo ocorre
        [pr,k] = min(abs(x(i,j) - X) + abs(y(i,j) - Y));
        % a altura Z(k) possibilita uma boa aproximacao da topografia
        % implicita pelo arquivo texto de entrada [X Y Z] atraves da
        % topografia [x y z] construida pelo programa
        z(i,j) = Z(k);
    end
end
h = figure;set(h,'Position',[700 350 560 420]);
surf(x,y,z);
%          FIM DA "Figure 2"                 %
clear x;
clear y;
clear i; % variavel i volta a ser a unidade imaginaria raiz(-1)
clear X;
clear Y;
clear Z;
% As dimensoes M e N da meshgrid sao usualmente muito grandes
% A divisao por 4 corresponde a um bom valor empirico testado
% para todos os casos praticos disponiveis
n = floor(N/4);
m = floor(M/4);
Z = z(1 : n : N,1 : m : M);
Z(end, : ) = z(end,1 : m : M);
Z( : ,end) = z(1 : n : N,end);
% M , N : dimensoes da nova meshgrid
M = length(Z(1, : ));
N = length(Z( : ,1));
% deslocamento da origem para o centro dos dados de entrada
Xctr = (Xmax + Xmin)/2;
Yctr = (Ymax + Ymin)/2;
Zctr = Xctr + i*Yctr;
X = linspace(Xmin,Xmax,M) - Xctr;
Y = linspace(Ymin,Ymax,N) - Yctr;
Xmin = X(1);
Xmax = X(end);
Ymin = Y(1);
Ymax = Y(end);
[x,y] = meshgrid(X,Y);
% p = polyfit(x,Z,M-1) calcula os coeficientes do polinomio p(x)
% de grau M-1 que aproxima os dados, p(x(i)) a Z(i),
% de acordo com o Metodo dos Minimos Quadrados
p = zeros(N,M);
for i = 1 : N
    p(i, : ) = polyfit(x(i, : ),Z(i, : ),M - 1);
end
% q = polyfit(y,p,N-1) calcula os coeficientes do polinomio q(x)
% de grau N-1 que aproxima os dados, q(y(j)) a p(j),
% de acordo com o Metodo dos Minimos Quadrados
q = zeros(N,M);
for j = 1 : M
    q( : ,j) = polyfit(y( : ,j),p( : ,j),N - 1);
end
%
% Mantem somente a variavel q(i,j) =
%            coeficientes do polinomio 2D
%
clear p;
clear i;
clear X;
clear Y;
clear x;
clear y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% construcao e desenho da superficie polinomial 2D
% sobre o reticulado [x,y] que aproxima a topografia
% do terreno
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = linspace(Xmin,Xmax,4*(M - 1) + 1);
Y = linspace(Ymin,Ymax,4*(N - 1) + 1);
[x,y] = meshgrid(X,Y);
% f define z, polinomio 2D nas coordenadas complexas
% (x(j,k),y(j,k)) = x(j,k) + i*y(j,k) = (X(k),Y(j))
%                                      j = 1, ... , 4*(M-1)+1
%                                      k = 1, ... , 4*(N-1)+1
% com coeficientes q(j,k), obtidos via polyfit;
% o grau de z(x,y) é ...
%
z = f(q,x + i*y,N,M);
%
h = figure; % FIGURE 3
set(h,'Position',[650 300 560 420]);
surf(x + Xctr,y + Yctr,z);
[C,LEV] = contourc(x,y,z,VN); % comando desnecessario
h = figure; % FIGURE 4
set(h,'Position',[520 368 850 650]);
hold on;
% desenha as curvas de nivel da aproximacao polinomial
contour(x + Xctr,y + Yctr,z,nlc);
grid('minor');
% variavel Pts e' usada somente por <cvxhull>
% ? melhor deixa'-la so' dentro de <cvxhull> ?
Pts = pts;
% determina o fecho convexo do talhao de plantio
cvxhull;
opts = pts - Zctr;
pts = Pts(1 : k + 1) - Zctr;
hold on;
% desenha o fecho convexo do talhao de plantio
plot([opts;opts(1)] + Zctr,'k');
plot([pts;pts(1)] + Zctr,'k');
plot(pts + Zctr,'rs');
axis equal;
%
% pontos extras para serem utilizados quando
% o talhao de plantio nao e' convexo
epts = [];
ekns = [];
fid = -1;
% construcao do nome de arquivo de pontos extras
% (altera variavel fid)
arq = strcat('e',arq);
fid = fopen(arq,'rt');
%
sv = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% se "length(opts) > length(pts)"
% entao o talhao de plantio NÃO E' CONVEXO
if length(opts) > length(pts)
    if fid == -1
        sv = 1;
        % construcao do arquivo de pts extras para subdivisao convexa
        fprintf('***************************************************************************\n');
        fprintf('   3) escolha pontos com botão esquerdo para subdividir talhao de plantio *\n');
        fprintf('   4) finalize com o botão direito do mouse                               *\n');
        fprintf('***************************************************************************\n');
        k = 1;
        prox = 3;
        ok = 0;
        button = 10;
        while button ~= 3 % nao pressionou o botao direito
            [aa,bb,button] = ginput(1);
            if button ~= 3
                epts(k) = aa + i*bb;
                plot(epts(k),'--gs','markerfacecolor','b');
                ok = 1;
            else
                ok = 0;
            end
            if ok
                k = k + 1;
            end
        end
        epts = epts.';%'
        Epts = epts;
    else  % se encontrou arquivo de pontos extras
        lis = textread(arq);
        fclose(fid);
        lis = lis;
        epts = lis(1 : 2 : end) + i*lis(2 : 2 : end);
        clear lis;
    end
end

if ~isempty(epts) % o arquivo de pontos extras foi construido
    epts = epts - Zctr;
    par = 1;
    Opts = opts(1);
    for k = 1 : length(opts) - 1
        vec = opts(k + 1) - opts(k);
        stp = abs(vec);
        if stp>10
            dvs = ceil(stp/10);
            vec = vec/dvs;
            for K = 1 : dvs
                par = [par,k];
                Opts = [Opts;opts(k) + K*vec];
            end
        end
    end
    eL = length(epts);
    for k = 1 : eL
        % prox =  distancia minima na norma-2 entre o ponto extra <epts(k)>
        %         e os pontos originais <Opts>
        % ii   =  indice onde o minimo ocorre; se existem varios minimos,
        %         a funcao retorna o primeiro encontrado
        [prox,ii] = min(abs(epts(k) - Opts));
        % o ponto extra epts(k) recebe o ponto original mais proximo
        epts(k) = Opts(ii);
    end
    for k = 1 : eL/2
        ekns = [ekns ; ( epts(2*k - 1) + epts(2*k) )/2];
    end
end
