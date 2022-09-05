classdef Map <handle
    properties
        parkingstate;%每个车位的状态
        localization(1,:) Localization;%定位每个车位，对应的是每个车位的格点
        costmap;
        lambda;
        p;
        car;%车
        changenum;%累计发生了多少次车位状态的变化
    end
    methods
        function map = Map(costmap,lambda,p)%初始化
            load('parkinglocation.mat');
            map.costmap = costmap;
            map.lambda = lambda;
            map.p = p;
            for m=1:90
                X = Z(m).grid1;
                Y = Z(m).grid2;
                map.localization(m) = Localization(X,Y);
                if rand>0.5
                    map.parkingstate(m) = 1;
                    setCosts(map.costmap,map.localization(m).allpoints,1);
                else
                    map.parkingstate(m) = 0;
                end
            end
            map.changenum = 0;
        end
        function UpdateState(map)
            for m = 1:90
                if map.parkingstate(m) == 1
                    if rand < map.p
                        setCosts(map.costmap,map.localization(m).allpoints,0);
                        map.parkingstate(m) = 0;
                        map.changenum = map.changenum + 1;
                    end
                else
                    if rand > exp((-1)*map.lambda)
                        setCosts(map.costmap,map.localization(m).allpoints,1);
                        map.parkingstate(m) = 1;
                        map.changenum = map.changenum + 1;
                    end
                end
            end
        end
    end
end


