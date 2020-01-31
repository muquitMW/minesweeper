function mVal = calculateMineNumber_Min(Gridsize,mnPs)
mVal        = zeros(Gridsize,Gridsize);%Position Matrix initialization
mVal(mnPs)  = Gridsize^2+1;%Assign Big value to Mine positions in Matrix
mVal        = mVal+(mVal<=0).*imfilter(mVal,ones(3,3))/(Gridsize^2+1);
end