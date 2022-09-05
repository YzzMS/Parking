function costmap = createThreeFifteenMap()
mapWidth = 70;
mapLength = 56;
cellSize = 0.25;

costmap = vehicleCostmap(mapWidth,mapLength,'CellSize',cellSize)
[X,Y] = meshgrid(0.25:cellSize:70,0.25:cellSize:56);
setCosts(costmap,[X(:),Y(:)],0)

[X,Y] = meshgrid(0.25:cellSize:70,[0.25,0.5,55.75,56]);
setCosts(costmap,[X(:),Y(:)],1)

[X,Y] = meshgrid([0.25,0.5],[0.25:cellSize:12,18:cellSize:56]);
setCosts(costmap,[X(:),Y(:)],1)

[X,Y] = meshgrid([69.75,70],[0.25:cellSize:47,53:cellSize:56]);
setCosts(costmap,[X(:),Y(:)],1)

[X,Y] = meshgrid(12:cellSize:57.25,[18.75,19,37.25,37.5]);
setCosts(costmap,[X(:),Y(:)],1)

for m=0:15
    [X,Y] = meshgrid([12+m*3,12.25+m*3],0.75:cellSize:6.5);
    setCosts(costmap,[X(:),Y(:)],1)
    [X,Y] = meshgrid([12+m*3,12.25+m*3],12.75:cellSize:18.5);
    setCosts(costmap,[X(:),Y(:)],1)
    [X,Y] = meshgrid([12+m*3,12.25+m*3],19.25:cellSize:25);
    setCosts(costmap,[X(:),Y(:)],1)
    [X,Y] = meshgrid([12+m*3,12.25+m*3],31.25:cellSize:37);
    setCosts(costmap,[X(:),Y(:)],1)
    [X,Y] = meshgrid([12+m*3,12.25+m*3],37.75:cellSize:43.5);
    setCosts(costmap,[X(:),Y(:)],1)
    [X,Y] = meshgrid([12+m*3,12.25+m*3],49.75:cellSize:55.5);
    setCosts(costmap,[X(:),Y(:)],1)
end

end