clc
close all force
clear
t_r=120;
t_g=120;
t_b=120;
vid = videoinput('winvideo', 1, 'MJPG_640x480');
flushdata(vid);
set(vid,'FramesPerTrigger',50);
set(vid,'ReturnedColorSpace','rgb');
vid.FrameGrabInterval=10;
start(vid);
hFig = figure('Toolbar','none',...
    'Menubar','none');
im=imread('test.jpg');
hIm=imshow(im);
hSP = imscrollpanel(hFig,hIm);
set(hSP,'Units','normalized',...
    'Position',[0 .1 1 .9]);
api = iptgetapi(hSP);
api_assigned=1;


while(vid.FramesAcquired<=50)
    data=getsnapshot(vid);
    if(api_assigned==0)
        hSP = imscrollpanel(hFig,hIm);
        set(hSP,'Units','normalized',...
            'Position',[0 .1 1 .9]);
        api = iptgetapi(hSP);
        api_assigned=1;
    end
    marker_prop=MarkTrack(data,1,[t_r,t_g,t_b],4);
    noOfPoints=size(marker_prop);
    if(noOfPoints(2)==1) %panning
        br=marker_prop(1);
        api.setMagnificationAndCenter(1,bm.Centroid);
        continue;
    else
        if(noOfPoints(2)==3) %zoom bigred smallred smallblue
            sr=marker_prop(1);
            sb=marker_prop(2);
            br=marker_prop(3);
            d_sr_sb=pointDist(sr.Centroid,sb.Centroid);
            d_sr_br=pointDist(sr.Centroid,br.Centroid);
            d_sb_br=pointDist(sb.Centroid,br.Centroid);
            ratio=d_sr_sb/d_sb_br;
            api.setMagnificationAndCenter(10^ratio,bm.Centroid);
        else
            if (noOfPoints(2)==2) %rotate smallred smallblue
                sr=marker_prop(1);
                sb=marker_prop(2);
                ang=atand((sb.Centroid(1)-sr.Centroid(1))/(sb.Centroid(2)-sr.Centroid(2)));
                im=imrotate(im,ang);
                hIm=imshow(im);
                api_assigned=0;
            end
        end
    end
end