function out=armCheck(x,y)
%This function gets x,y coords fo a centroid and returns the number of arm
%it is in. If the mouse is in the center of the maze it returns 0
    load 'polygon_x_list.mat'; load 'polygon_y_list.mat';
    found=0;
    counter=1;
    out=0;
    for i=1:6
        a=polygon_x_list(:,i);
        b=polygon_y_list(:,i);
        if ~found && inpolygon(x,y,a,b)
            found=1;
            out=i;
        end
    end
end
