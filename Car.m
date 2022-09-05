classdef Car <handle
    properties
        x;
        y;
        theta;%pose
        direction;
        observation(1,90) double {mustBeReal, mustBeFinite};%观测结果
        canobserve(1,:) double {mustBeReal, mustBeFinite};%能够观测到的车位编号
        map;
    end
    methods%方法块
        %构造函数，初始化
        function car = Car(x,y,theta,map)
                car.x = x;
                car.y = y;
                car.theta = theta;
                car.map = map;
                if ((theta >= 0) && (theta <= 45)) || ((theta >= 315) && (theta <360))
                    car.direction = "right";
                elseif (theta > 45) && (theta <= 135)
                    car.direction = "up";
                elseif (theta > 135) && (theta <= 225)
                    car.direction = "left";
                else
                    car.direction = "down";
                end
                car.observation = (-1)*ones(1,90);
                car.canobserve = [];
        end
        
        %改变位置
        function Move(car,x1,y1,theta1)
            car.x = car.x+x1;
            car.y = car.y+y1;
            car.theta = car.theta+theta1;
            if ((car.theta >= 0) && (car.theta <= 45)) || ((car.theta >= 315) && (car.theta <360))
                car.direction = "right";
            elseif (car.theta > 45) && (car.theta <= 135)
                car.direction = "up";
            elseif (car.theta > 135) && (car.theta <= 225)
                car.direction = "left";
            else
                car.direction = "down";
            end
        end
        
        %没有固定的观测范围的情况下，判断机器人能够观测到哪些车位
        function CanObserve(car)
            car.canobserve = [];
            p1 = floor((car.x - 12)/3);
            if (p1 >= 0) && (p1 <= 14)
                if ((car.theta >= 0) && (car.theta <= 90)) || ((car.theta >= 270) && (car.theta < 360))
                    if car.y >= 6.75 && car.y <= 12.5
                        car.canobserve(1) = p1+1;
                        car.canobserve(2) = p1+16;
                        if p1 <= 13
                            car.canobserve(3) = p1+2;
                            car.canobserve(4) = p1+17;
                        end
                        if p1 <= 12
                            car.canobserve(5) = p1+3;
                            car.canobserve(6) = p1+18;
                        end
                    elseif car.y >= 25.25 && car.y <= 31
                        car.canobserve(1) = p1+31;
                        car.canobserve(2) = p1+46;
                        if p1 <= 13
                            car.canobserve(3) = p1+32;
                            car.canobserve(4) = p1+47;
                        end
                        if p1 <= 12
                            car.canobserve(5) = p1+33;
                            car.canobserve(6) = p1+48;
                        end
                    elseif car.y >= 43.75 && car.y <= 49.5
                        car.canobserve(1) = p1+61;
                        car.canobserve(2) = p1+76;
                        if p1 <= 13
                            car.canobserve(3) = p1+62;
                            car.canobserve(4) = p1+77;
                        end
                        if p1 <= 12
                            car.canobserve(5) = p1+63;
                            car.canobserve(6) = p1+78;
                        end
                    end
                elseif (car.theta >= 90) && (car.theta <= 270)
                    if car.y >= 6.75 && car.y <= 12.5
                        car.canobserve(1) = p1;
                        car.canobserve(2) = p1+15;
                        if p1 >= 1
                            car.canobserve(3) = p1-1;
                            car.canobserve(4) = p1+14;
                        end
                        if p1 >= 2
                            car.canobserve(5) = p1-2;
                            car.canobserve(6) = p1+13;
                        end
                    elseif car.y >= 25.25 && car.y <= 31
                        car.canobserve(1) = p1+30;
                        car.canobserve(2) = p1+45;
                        if p1 >= 1
                            car.canobserve(3) = p1+29;
                            car.canobserve(4) = p1+44;
                        end
                        if p1 >= 2
                            car.canobserve(5) = p1+28;
                            car.canobserve(6) = p1+43;
                        end
                    elseif car.y >= 43.75 && car.y <= 49.5
                        car.canobserve(1) = p1+60;
                        car.canobserve(2) = p1+75;
                        if p1 >= 1
                            car.canobserve(3) = p1+59;
                            car.canobserve(4) = p1+74;
                        end
                        if p1 >= 2
                            car.canobserve(5) = p1+58;
                            car.canobserve(6) = p1+73;
                        end
                    end
                end
            elseif (p1 > 14) && (p1 <= 16)
                if car.direction == "up"
                    if car.y < 6.75
                        car.canobserve(1) = 15;
                    elseif car.y >= 6.75 && car.y <= 12.5
                        car.canobserve(1) = 30;
                    elseif car.y > 12.5 && car.y <= 18.75
                        car.canobserve(1) = 30;
                        car.canobserve(2) = 45;
                    elseif car.y >= 19 && car.y <= 25
                        car.canobserve(1) = 45;
                    elseif car.y >= 25.25 && car.y <= 31
                        car.canobserve(1) = 60;
                    elseif car.y >= 31.25 && car.y <= 37.25
                        car.canobserve(1) = 60;
                        car.canobserve(2) = 75;
                    elseif car.y >= 37.5 && car.y <= 43.5
                        car.canobserve(1) = 75;
                    elseif car.y >= 43.75
                        car.canobserve(1) = 90;  
                    end
                elseif car.direction == "down"
                    if car.y < 12.5
                        car.canobserve(1) = 15;
                    elseif car.y >= 12.5 && car.y <= 18.75
                        car.canobserve(1) = 30;
                    elseif car.y >=19 && car.y <= 25
                        car.canobserve(1) = 30;
                        car.canobserve(2) = 45;
                    elseif car.y >= 25.25 && car.y <= 31
                        car.canobserve(1) = 45;
                    elseif car.y >= 31.25 && car.y <= 37.25
                        car.canobserve(1) = 60;
                    elseif car.y >= 37.5 && car.y <= 43.5
                        car.canobserve(1) = 60;
                        car.canobserve(2) = 75;
                    elseif car.y >= 43.75 && car.y <= 49.5
                        car.canobserve(1) = 75;
                    elseif car.y >= 50
                        car.canobserve(1) = 90;  
                    end
                elseif car.direction == "left"
                    if car.y < 6.75
                        car.canobserve(1) = 15;
                        if p1 == 15
                            car.canobserve(2) = 14;
                        end
                    elseif car.y >= 6.75 && car.y <= 12.5
                        car.canobserve(1) = 15;
                        car.canobserve(2) = 30;
                        if p1 == 15
                            car.canobserve(3) = 14;
                            car.canobserve(4) = 29;
                        end
                    elseif car.y > 12.5 && car.y <= 25
                        car.canobserve(1) = 30;
                        car.canobserve(2) = 45;
                        if p1 == 15
                            car.canobserve(3) = 29;
                            car.canobserve(4) = 44;
                        end
                    elseif car.y >= 25.25 && car.y <= 31.25
                        car.canobserve(1) = 45;
                        car.canobserve(2) = 60;
                        if p1 == 15
                            car.canobserve(3) = 44;
                            car.canobserve(4) = 59;
                        end
                    elseif car.y >= 31.5 && car.y <= 43.5
                        car.canobserve(1) = 60;
                        car.canobserve(2) = 75;
                        if p1 == 15
                            car.canobserve(3) = 59;
                            car.canobserve(4) = 74;
                        end
                    elseif car.y >= 43.75
                        car.canobserve(1) = 90;
                        if p1 == 15
                            car.canobserve(3) = 89;
                        end
                    end
                end
            elseif (p1 < 0) && (p1 >= -2)
                if car.direction == "up"
                    if car.y < 6.75
                        car.canobserve(1) = 1;
                    elseif car.y >= 6.75 && car.y <= 12.5
                        car.canobserve(1) = 16;
                    elseif car.y > 12.5 && car.y <= 18.75
                        car.canobserve(1) = 16;
                        car.canobserve(2) = 31;
                    elseif car.y >= 19 && car.y <= 25
                        car.canobserve(1) = 31;
                    elseif car.y >= 25.25 && car.y <= 31
                        car.canobserve(1) = 46;
                    elseif car.y >= 31.25 && car.y <= 37.25
                        car.canobserve(1) = 46;
                        car.canobserve(2) = 61;
                    elseif car.y >= 37.5 && car.y <= 43.5
                        car.canobserve(1) = 61;
                    elseif car.y >= 43.75
                        car.canobserve(1) = 76;  
                    end
                elseif car.direction == "down"
                    if car.y < 12.5
                        car.canobserve(1) = 1;
                    elseif car.y >= 12.5 && car.y <= 18.75
                        car.canobserve(1) = 16;
                    elseif car.y >=19 && car.y <= 25
                        car.canobserve(1) = 16;
                        car.canobserve(2) = 31;
                    elseif car.y >= 25.25 && car.y <= 31
                        car.canobserve(1) = 31;
                    elseif car.y >= 31.25 && car.y <= 37.25
                        car.canobserve(1) = 46;
                    elseif car.y >= 37.5 && car.y <= 43.5
                        car.canobserve(1) = 46;
                        car.canobserve(2) = 61;
                    elseif car.y >= 43.75 && car.y <= 49.5
                        car.canobserve(1) = 61;
                    elseif car.y >= 50
                        car.canobserve(1) = 76;  
                    end
                elseif car.direction == "right"
                    if car.y < 6.75
                        car.canobserve(1) = 1;
                        if p1 == -1
                            car.canobserve(2) = 2;
                        end
                    elseif car.y >= 6.75 && car.y <= 12.5
                        car.canobserve(1) = 1;
                        car.canobserve(2) = 16;
                        if p1 == -1
                            car.canobserve(3) = 2;
                            car.canobserve(4) = 17;
                        end
                    elseif car.y > 12.5 && car.y <= 25
                        car.canobserve(1) = 16;
                        car.canobserve(2) = 31;
                        if p1 == -1
                            car.canobserve(3) = 17;
                            car.canobserve(4) = 32;
                        end
                    elseif car.y >= 25.25 && car.y <= 31.25
                        car.canobserve(1) = 31;
                        car.canobserve(2) = 46;
                        if p1 == -1
                            car.canobserve(3) = 32;
                            car.canobserve(4) = 47;
                        end
                    elseif car.y >= 31.5 && car.y <= 43.5
                        car.canobserve(1) = 46;
                        car.canobserve(2) = 61;
                        if p1 == -1
                            car.canobserve(3) = 47;
                            car.canobserve(4) = 62;
                        end
                    elseif car.y >= 43.75
                        car.canobserve(1) = 76;  
                        if p1 == -1
                            car.canobserve(2) = 77;
                        end
                    end
                end
            end
        end
        
        %存在固定的观测范围的情况下，给定车位判断机器人可否看到
        function p = ObserveOne(car,idx)
            load('parkinglocation.mat');
            p = 0;
            X = Z(idx).grid1;
            Y = Z(idx).grid2;
            t = [X(:),Y(:)];
            xx = t(:,1) - 0.25;
            yy = t(:,2) - 0.25;
            x0 = car.x;
            y0 = car.y;
            theta = car.theta;
            x1 = x0 + 10 * sind(theta);
            y1 = y0 - 10 * cosd(theta);
            x2 = x0 + 10 * sind(theta) + 10 * cosd(theta);
            y2 = y0 + 10 * sind(theta) - 10 * cosd(theta);
            x3 = x0 - 10 * sind(theta) + 10 * cosd(theta);
            y3 = y0 + 10 * sind(theta) + 10 * cosd(theta);
            x4 = x0 - 10 * sind(theta);
            y4 = y0 + 10 * cosd(theta);%观测范围的四个角
            xv = [x1,x2,x3,x4];
            yv = [y1,y2,y3,y4];
            in = inpolygon(xx,yy,xv,yv);
            num = 0;
            for m = 1:size(in,1)
                if in(m) == 1
                    num = num + 1;
                    if num >= 80
                        p = 1;
                    end
                end
            end
        end
        
        %存在固定的观测范围的情况下，判断机器人能够观测到哪些车位
        function CanObserve1(car)
            car.canobserve = [];
            num = 0;
            for m = 1:90
                if car.ObserveOne(m)
                    num = num + 1;
                    car.canobserve(num) = m;
                end
            end
        end
        
        %观测，已经知道有哪些车位能够观测到的情况下
        function Observe(car,costmap)
            car.observation = (-1)*ones(1,90);
            for i = 1:size(car.canobserve,2)
                load('parkinglocation.mat');
                X = Z(car.canobserve(i)).grid1;
                Y = Z(car.canobserve(i)).grid2;
                a = getCosts(costmap,[X(:),Y(:)]);
                if a(1) == 1
                    if rand > 0.9
                        car.observation(car.canobserve(i)) = 0;%观测结果为空
                    else
                        car.observation(car.canobserve(i)) = 1;%观测结果为满
                    end
                else
                    if rand > 0.7
                       car.observation(car.canobserve(i)) = 1;
                    else
                        car.observation(car.canobserve(i)) = 0;
                    end
                end
            end
        end
    end				
end

