function main(filename,plotflag)
    %This function reads Radial Arm Water Maze video filename and exports 
    %the behavioral stats to an excel sheet:
    %-Duration to the platform (number of frames/fps)
    %-Full arms visit history (1-6)
    %-Grades: a vecor of 1X6. Its numbers mean: 0=no entry to arm, 1=one entry to arm 
    %        2=one normal entry to arm and another short entry, 3= two long entries,
    %        4=3 or more entries to the same arm
    %If 'plotflag' true - A binary image of the mouse and its trail, and 
    %next to it the actual frame will appear "live".
    
    load 'xv.mat';load 'yv.mat'; %Loads maze coords for polygon function 
    vid_in=VideoReader(filename);
    counter=0;
    avarea=0;
    appear=0;
    lastX=0;
    lastY=0;
    mouse_in_frame=0;
    lastp=struct('Area',0,'Centroid',[ 1 1]); %Saves last location - used as backup incase of no centroid is found
    centHis=zeros(426 ,640);
    lastBW=[];
    rawHistory=zeros(1500,1); %Mouse trail (arms number 1-6)
    video = VideoWriter('yourvideo.avi'); %create the video object
    open(video); %open the file for writing
    %Reading video
    video = VideoWriter('yourvideo.avi'); %create the video object
    open(video); %open the file for writing
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
                   if ~inpolygon(x(1),x(2),xv,yv) ||  a < 190 || a >450
                       %All pixels found by "region props" that are out of the polygon coords 
                       %or its area is larger than 450 pixles 
                       %or smaller than 190 - pixles are changed to be false
                        pixels=props(k).PixelIdxList;
                        BW2(pixels)=false;
                        ind(1,end+1)=k;
                   end
                end         
                props(ind)=[];

            end

            if length(props)==1
                mouse_in_frame=mouse_in_frame+1;
                xy=props.Centroid;
                lastX=xy(1);
                lastY=xy(2);
                curArm=armCheck(lastX,lastY);
                rawHistory(nnz(rawHistory)+1)=curArm;
                lastp=props;
                [thex ,they]=circleC(30*1.5);
                centHis(round(lastY),round(lastX))=1;
                BW2(centHis>0)=1;
                lastBW=BW2;
                %%
                a=imshow(frame);viscircles([round(lastX),round(lastY)],50);hold on;
                imwrite(frame,'file_name.tif');
                I = imread('file_name.tif'); %read the next image
                writeVideo(video,I); %write the image to file
                if plotflag
                    plotting(BW2,counter,frame,thex,they,props);
                end        
            else
                [thex ,they]=circleC(30*1.5);
                props=lastp;
                BW2=lastBW;
                %%
                imwrite(frame,'file_name.tif');
                I = imread('file_name.tif'); %read the next image
                writeVideo(video,I); %write the image to file
                
                if plotflag
                    plotting(BW2,counter,frame,thex,they,props);
                end
           
            end

        end

    end
    [cleaned,armsCount]=clean(rawHistory);
    finalG=grades(cleaned);
    expData1={filename};
    expData2={'time',mouse_in_frame/25};
    expData3=finalG;
    Export(expData1,expData2,expData3);