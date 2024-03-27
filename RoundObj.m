clc; clear; clearvars; close all hidden
I = imread('C:\Users\Dell XPS White\Desktop\MATLAB\Computer_Vision\RoundObj.png');
Ibw = im2bw(I);
Ibw = bwareaopen(Ibw,400);
se = strel('disk',2);
Ibw = imclose(Ibw,se);
Ibw = imfill(Ibw, 'holes');
Ilabel = bwlabel(Ibw);
stat = regionprops(Ilabel, 'all');
n = 0;
imshow(I);
hold on;
for x = 1:numel(stat)
    area = stat(x).Area;
   perimeter = stat(x).Perimeter;
   circularity = (4*area*pi)/perimeter.^2;
   if circularity > 0.9
      plot(stat(x).Centroid(1), stat(x).Centroid(2), 'ro','LineWidth',2);
      n = n + 1;
   end
   metric_string = sprintf('%2.2f', circularity);
   text(stat(x).Centroid(1),stat(x).Centroid(2)+25,metric_string,'Color','m','FontSize',14,'FontWeight','bold');
end
disp(['Total number of round objects = ' num2str(n)]);