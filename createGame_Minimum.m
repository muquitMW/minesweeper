function createGame_Minimum(mnum,grsz,esz)
% Calculates number of mines in neighboring 3x3 grids for each grid
%input
%mnum: Number of mines 
%grsz: N, where the total Number of grids is NxN 
%esz:  Length of each grid (pixel)
%Output
%None

hF      = figure('Position',[50 100 1.2*grsz*(esz+1) 1.2*grsz*(esz+1)],'numbertitle','off','Name',['(',num2str(mnum),')']);%�ŏ���Figure�����܂�
pnlL    = [grsz*(esz+1)+3 grsz*(esz+1)+2];%Figure�ɕt����p�l���̒����v�Z
pnlS    = [(hF.Position(3) - pnlL(1))/2 (hF.Position(4) - pnlL(2))/2];%Figure�ɂ���p�l���̕����v�Z
pnl     = uipanel(hF,'Units','Pixel','Position',[pnlS pnlL],'title','');%�p�l���쐬
mVal    = calculateMineNumber_Min(grsz,randperm(grsz^2,mnum));%�����ɂ���ă}�C�������˃O���b�h���ƂɎ��ӂ̃}�C�������v�Z����֐�
[PX,PY] = meshgrid(1:(esz+1):grsz*(esz+1),1:(esz+1):grsz*(esz+1));%���ꂼ��̃O���b�h�̈ʒu����C�Ɍv�Z
bI      = mVal<= 0;%�v�Z�Ɏg�����ߎ��ӂɃ}�C�����Ȃ��O���b�h�̃C���f�b�N�X�𒊏o
st      = regionprops(bI,'PixelList','PixelIdxList');%���ӂɃ}�C�����Ȃ��O���b�h�̉���쐬
bHndl   = repmat(uicontrol(pnl),[grsz,grsz]);%�O���b�h�쐬�p�A�e�O���b�h�̃n���h����������
for k   = 1 : grsz^2 %Loop�Ługrsz�~grsz�v�̃O���b�h���쐬
    bHndl(k) = uicontrol(pnl,'Position',[PX(k),PY(k),esz,esz],'UserData',mVal(k),'String',mVal(k),'ForegroundColor',[0.9 0.9 0.9],'BackgroundColor',[0.9 0.9 0.9]);%�O���b�h�쐬
end
set(bHndl,'Callback',{@coreFcn_M,grsz,bI,st,bHndl});%���ꂼ��̃O���b�h���N���b�N������ғ�����R�[���o�b�N�֐���K�p
