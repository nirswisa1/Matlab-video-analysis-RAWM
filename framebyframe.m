filename='Trial   112.mpg';
vid_in=VideoReader(filename);
counter=0;
avarea=0;
appear=0;
lastX=0;
lastY=0;
lastp=struct('Area',0,'Centroid',[ 1 1]);
centHis=zeros(426 ,640);
lastBW=[];
while vid_in.hasFrame&&counter<vid_in.NumFrames %code ends while reaching the number of frames
    counter=counter+1;
    frame=readFrame(vid_in);
    
    if counter==1
        first=frame(:,:,2); invOne=uint8(255)-first;  
    else
        mouse=frame(:,:,2);invMouse=uint8(255)-mouse;   
        sub=invMouse-invOne;
        BW=imbinarize(sub,13/255);
        props=regionprops(BW,'Area','Centroid','PixelIdxList');
        ind=[];
        BW2=BW; 
        if ~isempty(props)
            for k=1:length(props)
               x=props(k).Centroid;
               a=props(k).Area;
               if a < 190 || a >450 ||x(1)<143||x(1)>585 || x(2)>413
                    pixels=props(k).PixelIdxList;
                    BW2(pixels)=false;
                    ind(1,end+1)=k;
               end
            end         
            props(ind)=[];
            
        end
        
        if length(props)==1
            xy=props.Centroid;
            lastX=xy(1);
            lastY=xy(2);
            lastp=props;
            [thex ,they]=circleC(30*1.5);
            centHis(round(lastY),round(lastX))=1;
            BW2(centHis>0)=1;
            lastBW=BW2;
            %subplot(1,2,1);imshow(BW2);title(counter);drawnow;
            %subplot(1,2,2);imshow(frame); hold on;plot(thex+props.Centroid(1), they+props.Centroid(2),'color',[1 1 1])             
        else
            [thex ,they]=circleC(30*1.5);
            props=lastp;
            BW2=lastBW;
            %subplot(1,2,1);imshow(BW2);title(counter);drawnow;
            %subplot(1,2,2);imshow(frame); hold on;plot(thex+props.Centroid(1), they+props.Centroid(2),'color',[1 1 1])             
        end
        
    end
    
end