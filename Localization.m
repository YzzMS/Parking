classdef Localization <handle
    properties
        point1;
        point2;
        allpoints;
    end
    methods
        function localization = Localization(X,Y)
            localization.allpoints = [X(:),Y(:)];
            localization.point1 = X(1,1);
            localization.point2 = Y(1,1);
        end
    end
end