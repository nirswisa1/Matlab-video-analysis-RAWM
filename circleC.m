function [thex they]=circleC(r)
%Creates a circle to plot using the radius 'r'. Returning the x and y
    theta=linspace(0,2*pi,200);
    thex=r*cos(theta);
    they=r*sin(theta);
end