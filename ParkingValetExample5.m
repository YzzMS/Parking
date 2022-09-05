costmap = createThreeFifteenMap();
load('parkinglocation.mat')
%假设每辆车的速度为6m/s（约为20km/h，限速是30km/h）
%假设每秒更新一次，期望中1s内有0.005辆汽车经过每个停车位（200s——1辆/停车位，90个停车位）
%假设每秒每辆车有1%概率离开停车场（停车时间期望——200s）
map = Map(costmap,0.01,0.01);
figure
plot(map.costmap, 'Inflation', 'off')
legend off
map.costmap.MapExtent % [x, width, y, height] in meters

map.costmap.CellSize  % cell size in meters
vehicleDims = vehicleDimensions;
maxSteeringAngle = 35; % in degrees
map.costmap.CollisionChecker.VehicleDimensions = vehicleDims;
map.costmap.CollisionChecker.NumCircles = 7;
vehicleDims
%%
car1 = Car(5,10,0,map);
hold on
helperPlotVehicle([car1.x,car1.y,car1.theta], vehicleDims, ...
    'displayName', 'Car 1')
legend

%%
%detectresult = DetectAlllocation(car1,costmap);%初始时刻观测
%%

%车位状态更新-车辆移动-车辆观测

%直线前进
for k = 1:9
    UpdateState(map);
    Move(car1,6,0,0);
    CanObserve1(car1);
    Observe(car1,map.costmap);
    plot(map.costmap, 'Inflation', 'off')
    %观测结果和真实结果一样，标注为绿色；若不一样就标记为红色
    for m = 1:size(car1.canobserve,2)
        if car1.observation(car1.canobserve(m)) == car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','g','linewidth',1.8);
        end
        if car1.observation(car1.canobserve(m)) ~= car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','r','linewidth',1.8);
        end
    end
    hg = hgtransform;
    rectangle('Position',[car1.x,car1.y-10,10,20],'Curvature',[0 0],'edgecolor','y','parent',hg,'linewidth',1.8);
    M1 = makehgtform('translate',[(-1)*car1.x (-1)*car1.y 0]);
    M2 = makehgtform('zrotate',pi/180*car1.theta);
    M3 = makehgtform('translate',[car1.x car1.y 0]);
    hg.Matrix = M3*M2*M1;
    helperPlotVehicle([car1.x,car1.y,car1.theta], vehicleDims, ...
     'Color',  [0, 0.4470, 0.7410])
    str1 = ['第',num2str(k),'个图.png'];
    print(gcf,str1,'-dpng');
    pause(0.5);
end

%转角
for k = 1:3
    UpdateState(map);
    Move(car1,2,2,30);
    CanObserve1(car1);
    Observe(car1,map.costmap);
    plot(map.costmap, 'Inflation', 'off')
    for m = 1:size(car1.canobserve,2)
        if car1.observation(car1.canobserve(m)) == car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','g','linewidth',1.8);
        end
        if car1.observation(car1.canobserve(m)) ~= car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','r','linewidth',1.8);
        end
    end
    hg = hgtransform;
    rectangle('Position',[car1.x,car1.y-10,10,20],'Curvature',[0 0],'edgecolor','y','parent',hg,'linewidth',1.8);
    M1 = makehgtform('translate',[(-1)*car1.x (-1)*car1.y 0]);
    M2 = makehgtform('zrotate',pi/180*car1.theta);
    M3 = makehgtform('translate',[car1.x car1.y 0]);
    hg.Matrix = M3*M2*M1;
    helperPlotVehicle([car1.x,car1.y,car1.theta], vehicleDims, ...
     'Color',  [0, 0.4470, 0.7410])
    str1 = ['第',num2str(k+9),'个图.png'];
    print(gcf,str1,'-dpng');
    pause(0.5);
end

%向上
for k = 1:4
    UpdateState(map);
    Move(car1,0,6,0);
    CanObserve1(car1);
    Observe(car1,map.costmap);
    plot(map.costmap, 'Inflation', 'off')
    for m = 1:size(car1.canobserve,2)
        if car1.observation(car1.canobserve(m)) == car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','g','linewidth',1.8);
        end
        if car1.observation(car1.canobserve(m)) ~= car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','r','linewidth',1.8);
        end
    end
    hg = hgtransform;
    rectangle('Position',[car1.x,car1.y-10,10,20],'Curvature',[0 0],'edgecolor','y','parent',hg,'linewidth',1.8);
    M1 = makehgtform('translate',[(-1)*car1.x (-1)*car1.y 0]);
    M2 = makehgtform('zrotate',pi/180*car1.theta);
    M3 = makehgtform('translate',[car1.x car1.y 0]);
    hg.Matrix = M3*M2*M1;
    helperPlotVehicle([car1.x,car1.y,car1.theta], vehicleDims, ...
     'Color',  [0, 0.4470, 0.7410])
    str1 = ['第',num2str(k+12),'个图.png'];
    print(gcf,str1,'-dpng');
    pause(0.5);
end

%左转
for k = 1:3
    UpdateState(map);
    Move(car1,-2,2,30);
    CanObserve1(car1);
    Observe(car1,map.costmap);
    plot(map.costmap, 'Inflation', 'off')
    for m = 1:size(car1.canobserve,2)
        if car1.observation(car1.canobserve(m)) == car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','g','linewidth',1.8);
        end
        if car1.observation(car1.canobserve(m)) ~= car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','r','linewidth',1.8);
        end
    end
    hg = hgtransform;
    rectangle('Position',[car1.x,car1.y-10,10,20],'Curvature',[0 0],'edgecolor','y','parent',hg,'linewidth',1.8);
    M1 = makehgtform('translate',[(-1)*car1.x (-1)*car1.y 0]);
    M2 = makehgtform('zrotate',pi/180*car1.theta);
    M3 = makehgtform('translate',[car1.x car1.y 0]);
    hg.Matrix = M3*M2*M1;
    helperPlotVehicle([car1.x,car1.y,car1.theta], vehicleDims, ...
     'Color',  [0, 0.4470, 0.7410])
    str1 = ['第',num2str(k+16),'个图.png'];
    print(gcf,str1,'-dpng');
    pause(0.5);
end

%直线前进
for k = 1:3
    UpdateState(map);
    Move(car1,-6,0,0);
    CanObserve1(car1);
    Observe(car1,map.costmap);
    plot(map.costmap, 'Inflation', 'off')
    for m = 1:size(car1.canobserve,2)
        if car1.observation(car1.canobserve(m)) == car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','g','linewidth',1.8);
        end
        if car1.observation(car1.canobserve(m)) ~= car1.map.parkingstate(car1.canobserve(m))
            rectangle('Position',[map.localization(car1.canobserve(m)).point1,map.localization(car1.canobserve(m)).point2,1.75,5],'edgecolor','r','linewidth',1.8);
        end
    end
    hg = hgtransform;
    rectangle('Position',[car1.x,car1.y-10,10,20],'Curvature',[0 0],'edgecolor','y','parent',hg,'linewidth',1.8);
    M1 = makehgtform('translate',[(-1)*car1.x (-1)*car1.y 0]);
    M2 = makehgtform('zrotate',pi/180*car1.theta);
    M3 = makehgtform('translate',[car1.x car1.y 0]);
    hg.Matrix = M3*M2*M1;
    helperPlotVehicle([car1.x,car1.y,car1.theta], vehicleDims, ...
     'Color',  [0, 0.4470, 0.7410])
    str1 = ['第',num2str(k+19),'个图.png'];
    print(gcf,str1,'-dpng');
    pause(0.5);
end

%%
FramePath = 'C:\Users\29096\Desktop\停车空位搜索与估计\carparking\';  %图像序列所在路径
StartFrame = 1;  %定义初始帧
EndFrame = 22; %定义结束帧。
%生成视频及参数设定
video=VideoWriter('C:\Users\29096\Desktop\停车空位搜索与估计\carparking\情况5');  %创建一个视频文件，默认是avi格式
video.FrameRate=0.5; %设置帧速率
open(video); %打开视频
%写入图片
for i=StartFrame:EndFrame
    disp(i);
    frames=imread([FramePath ,'第',num2str(i),'个图.png']);
    writeVideo(video,frames); %将当前图片写入视频
end
map.changenum
