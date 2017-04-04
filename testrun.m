clc
close all force
clear
t_r=120;
t_g=120;
t_b=120;
vid = videoinput('winvideo', 1, 'MJPG_320x240');
flushdata(vid);
% set(vid,'FramesPerTrigger',50);
set(vid,'ReturnedColorSpace','rgb');
vid.FrameGrabInterval=5;
start(vid);
while(vid.FramesAcquired<=Inf)
    data=getsnapshot(vid);
    MarkTrack(data,1,[t_r,t_g,t_b],4);
end
stop(vid);