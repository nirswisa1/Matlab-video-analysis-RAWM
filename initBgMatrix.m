function bgmatrix=initBgMatrix(filename)
%initiate the bg matrix that will be substructed from each frame
vid_in = VideoReader(filename);
counter=0;
bg=double(readFrame(vid_in));
while vid_in.hasFrame&&counter<vid_in.NumFrames
    counter=counter+1;
    im=double(readFrame(vid_in));
    bg=im+bg;
end
bgmatrix=uint8(bg/counter);
end