function [out,out1]=clean(rawhistory)
%This function gets a vector of numbers presenting the history of arms the
%mouse has been in. "out" returns the original vector
%"out1" returns the same vector but ignors visits of 9 and
%less frames. That is because this amount of visits in one arm shows its an
%error (a short reflection of the light in the water that created a
%mistake)
    a=rawhistory;
    b=[0 0 0 0 0 0];
    for i=1:6
        if length(a(a==i))<10
            a(a==i)=0;
        end
        b(1,i)=length(a(a==i));
    end
    out=a;
    out1=b;    
end