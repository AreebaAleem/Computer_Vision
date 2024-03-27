clc; clear; clearvars; close all hidden;
I = imread('C:\Users\Dell XPS White\Desktop\MATLAB\Computer_Vision\3.jpeg');
Igray = rgb2gray(I);
Ibw = im2bw(Igray);
Ibw = bwareaopen(Ibw, 200);
se = strel('disk', 2);
Ibw = imclose(Ibw, se);
Ibw = imfill(Ibw, 'holes');
Ilabel = bwlabel(Ibw); 
stat = regionprops(Ilabel, 'all');
imshow(I);
hold on;
for x = 1:numel(stat)
    area = stat(x).Area;
    perimeter = stat(x).Perimeter;
    circularity = (4*pi*area)/perimeter.^2;
    if circularity < 0.07 && area > 200
        text(stat(x).Centroid(1),stat(x).Centroid(2),'Banana','Color','m','FontSize',14,'FontWeight','bold');
    elseif circularity > 0.6 && area > 200
        text(stat(x).Centroid(1),stat(x).Centroid(2),'Orange','Color','g','FontSize',14,'FontWeight','bold');
    elseif circularity > 0.3 && circularity < 0.6 && area > 230 && area < 244
        text(stat(x).Centroid(1),stat(x).Centroid(2),'Apple','Color','y','FontSize',14,'FontWeight','bold');
    end
end