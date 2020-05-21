function mVal = calculateMineNumber_Min(Gridsize,mnPs)
% Calculates number of mines in neighboring 3x3 grids for each grid
%input
%Gridsize:  N, where the total Number of grids is NxN 
%mnPs:      Position of each mine on grid coordinate
%Output
%mVal:      Matrix of number of mines (size, GridsizexGridsize)

mVal        = zeros(Gridsize,Gridsize);%Position Matrix initialization
mVal(mnPs)  = Gridsize^2+1;%Assign Big value to Mine positions in Matrix
mVal        = mVal+(mVal<=0).*imfilter(mVal,ones(3,3))/(Gridsize^2+1);
end