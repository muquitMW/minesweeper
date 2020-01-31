function coreFcn_M(hndl,~,Gridsize,bI,st,bHndl)
if hndl.UserData > Gridsize^2    %If hits Mine
    set(hndl,'BackgroundColor',[1 0 0],'ForegroundColor',[0 0 0],'String','Åú');
    errordlg('Game Over!','!!!');
    set(bHndl,'Callback','');
elseif hndl.UserData == 0       %If hits a block without number (Should expand to all connected blocks without number)
    hInd    = find(bHndl==hndl);    %Find blob containing current button
    for k = 1 : numel(st)
        if ~any(st(k).PixelIdxList == hInd)
            bI(st(k).PixelIdxList) = false; %only keep the current button blob alive
        end
    end
    bI = bwmorph(bI,'thick',1); %Expand one pixel to border for current button blob
    UD = [bHndl.UserData]';
    set( bHndl(bI(:)&UD<=Gridsize^2),'Style','Edit','Enable','inactive','ForegroundColor',[0 0 0],'BackgroundColor',[1 1 1]);
    set( bHndl(bI(:)&UD<=Gridsize^2&UD<=0),'String','')
else %If hits a block with number
    set(hndl,'Style','Edit','Enable','inactive','ForegroundColor',[0 0 0],'BackgroundColor',[1 1 1]);
end
%Win check
if sum(~strcmpi({bHndl.Style},'edit'))==sum([bHndl.UserData]>Gridsize^2)
    msgbox('Congratulations!!','WIN')
end
end