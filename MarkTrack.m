function cen = MarkTrack( im,color,threshold,n )
[width, height, ~]= size(im);
t_r=threshold(1);
t_g=threshold(2);
t_b=threshold(3);
result=zeros(width,height);
if (color==1)
    result=(im(:,:,1)>t_r & im(:,:,2)<t_g & im(:,:,3)<t_b);
else
    if (color==2)
        result=(im(:,:,1)<t_r & im(:,:,2)>t_g & im(:,:,3)<t_b);
    else
        result=(im(:,:,1)<t_r & im(:,:,2)<t_g & im(:,:,3)>t_b);
    end
end
result=imfill(imerode(result,strel('disk',3)),'holes');
%result=imdilate(result,strel('disk',2));
imshow(imfuse(result,im));
% s=regionprops(bwlabel(result),'Centroid','Area');
% [~, ind]=sort([s.Area]);
% s=s(ind);
% cen=0;
% if (isempty(s)==0)
%     cen=s(1);
%     for i=2:n
%         cen=[cen s(i)];
%     end
%     toc
%     cen.Centroid

end