function createGame_Minimum(mnum,grsz,esz)
% Calculates number of mines in neighboring 3x3 grids for each grid
%input
%mnum: Number of mines 
%grsz: N, where the total Number of grids is NxN 
%esz:  Length of each grid (pixel)
%Output
%None

hF      = figure('Position',[50 100 1.2*grsz*(esz+1) 1.2*grsz*(esz+1)],'numbertitle','off','Name',['(',num2str(mnum),')']);%最初はFigureを作ります
pnlL    = [grsz*(esz+1)+3 grsz*(esz+1)+2];%Figureに付けるパネルの長さ計算
pnlS    = [(hF.Position(3) - pnlL(1))/2 (hF.Position(4) - pnlL(2))/2];%Figureにつけるパネルの幅を計算
pnl     = uipanel(hF,'Units','Pixel','Position',[pnlS pnlL],'title','');%パネル作成
mVal    = calculateMineNumber_Min(grsz,randperm(grsz^2,mnum));%乱数によってマイン生成⇒グリッドごとに周辺のマイン数を計算する関数
[PX,PY] = meshgrid(1:(esz+1):grsz*(esz+1),1:(esz+1):grsz*(esz+1));%それぞれのグリッドの位置を一気に計算
bI      = mVal<= 0;%計算に使うため周辺にマインがないグリッドのインデックスを抽出
st      = regionprops(bI,'PixelList','PixelIdxList');%周辺にマインがないグリッドの塊を作成
bHndl   = repmat(uicontrol(pnl),[grsz,grsz]);%グリッド作成用、各グリッドのハンドルを初期化
for k   = 1 : grsz^2 %Loopで「grsz×grsz」のグリッドを作成
    bHndl(k) = uicontrol(pnl,'Position',[PX(k),PY(k),esz,esz],'UserData',mVal(k),'String',mVal(k),'ForegroundColor',[0.9 0.9 0.9],'BackgroundColor',[0.9 0.9 0.9]);%グリッド作成
end
set(bHndl,'Callback',{@coreFcn_M,grsz,bI,st,bHndl});%それぞれのグリッドをクリックしたら稼働するコールバック関数を適用
