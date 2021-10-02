function [props,BW]=channleGreen(mat,bg)
%returns a struct that contains the Area, Centroid and PixelIdxList
%mat-current frame to work on
%bg - the calculated background to substruct
sub=mat-bg;
green=sub(:,:,2);
BW=imbinarize(green,51/255);
props=regionprops(BW,'Area','Centroid','PixelIdxList');
end