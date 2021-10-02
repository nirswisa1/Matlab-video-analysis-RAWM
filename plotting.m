function out=plotting(BW2,counter,frame,thex,they,props)
    subplot(1,2,1);imshow(BW2);title(counter);drawnow;
    subplot(1,2,2);imshow(frame); hold on;plot(thex+props.Centroid(1), they+props.Centroid(2),'color',[1 1 1]);title(counter);drawnow;
end
