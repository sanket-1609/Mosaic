clc
close all force
clear
t_r=120;
t_g=120;
t_b=120;
vid = videoinput('winvideo', 1, 'MJPG_1280x720');
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
mag=1;

while(vid.FramesAcquired<=50)
    data=getsnapshot(vid);
    if(api_assigned==0)
        hSP = imscrollpanel(hFig,hIm);
        set(hSP,'Units','normalized',...
            'Position',[0 .1 1 .9]);
        api = iptgetapi(hSP);
        api_assigned=1;
    end
    [marker_prop,noOfPoints]=RGBWheelTrack(data,10);
    if(noOfPoints(2)==1) %panning
        m1=marker_prop(1);
        api.setMagnificationAndCenter(mag,m1.Centroid);
        continue;
    else
        if(noOfPoints(2)==3) %zoom bigred smallred smallblue
            hp=marker_prop(1);%highest point lowest i??
            mp=marker_prop(2);
            lp=marker_prop(3);%lowest point  highest i??
            d_hp_lp=pointDist(hp.Centroid,lp.Centroid);
            d_mp_lp=pointDist(mp.Centroid,lp.Centroid);
            d_hp_mp=pointDist(hp.Centroid,mp.Centroid);
            ratio=d_hp_lp/d_mp_lp;
            mag=(10^ratio)/9;
            api.setMagnificationAndCenter(mag,lp.Centroid);
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