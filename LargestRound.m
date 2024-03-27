clc; clear; clearvars; close all hidden;
I = imread('C:\Users\Dell XPS White\Desktop\MATLAB\Computer_Vision\RoundObj.png');
Ibw = im2bw(I);
Ibw = bwareaopen(Ibw,400);
se = strel('disk',2);
Ibw = imclose(Ibw,se);
Ibw = imfill(Ibw, 'holes');
Ilabel = bwlabel(Ibw);
stat = regionprops(Ilabel, 'all');
largestArea = 0;
largestIndex = 0;
imshow(I); 
hold on;
for x = 1:numel(stat)
    area = stat(x).Area;
    perimeter = stat(x).Perimeter;
    circularity= (4*area*pi)/perimeter.^2;
    if circularity > 0.9 && area > largestArea
        largestArea=area;
        largestIndex=x;
    end
end
if largestIndex > 0
    plot(stat(largestIndex).Centroid(1), stat(largestIndex).Centroid(2), 'mo','LineWidth',2);
    text(stat(largestIndex).Centroid(1)-25,stat(largestIndex).Centroid(2)+25,'Largest','Color','g','FontSize',14,'FontWeight','bold');
end