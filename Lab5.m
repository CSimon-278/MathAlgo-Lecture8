%% Lab 5: Edge Detection and Segmentation
close all;
clear;
clc;

I = im2double(rgb2gray(imread('peppers.png')));

%% 1) Basic derivative filters (Sobel, Prewitt)
% Sobel and Prewitt detect edges by computing image gradients in
% horizontal and vertical directions.
edges_sobel = edge(I,'Sobel');
edges_prewitt = edge(I,'Prewitt');

figure;
montage({edges_sobel, edges_prewitt},'Size',[1 2]);
title('Sobel | Prewitt edges');

%% 2) Canny detector (multi-stage)
% Canny uses gradient magnitude, non-maximum suppression, and hysteresis
% thresholding for clean, thin edges.
edges_canny = edge(I,'Canny',[0.05 0.2]);

figure;
imshow(edges_canny);
title('Canny edges');

%% 3) Laplacian of Gaussian (LoG)
% LoG detects edges by finding zero-crossings after smoothing with a
% Gaussian filter.
edges_log = edge(I,'log');

figure;
imshow(edges_log);
title('Laplacian of Gaussian edges');

%% 4) Edge map → segmentation (Otsu threshold)
% Otsu's method finds an optimal global threshold by maximizing
% inter-class variance in the histogram.
level = graythresh(I); % Otsu method
BW = imbinarize(I,level);

figure;
montage({I,BW},'Size',[1 2]);
title('Original | Otsu threshold binary mask');

%% 5) Label and visualize regions
% Connected components in the binary mask are labeled and visualized
% with unique colors.
[L,num] = bwlabel(BW);
RGB = label2rgb(L);

figure;
imshow(RGB);
title(['Labeled regions: ',num2str(num)]);

%% 6) Reflections
% - Which operator gives the thinnest, cleanest edges?
% The Canny detector produces the thinnest and cleanest edges due to its
% multi-stage process and non-maximum suppression.

% - Why does Canny outperform simple gradient filters?
% Canny includes noise reduction, edge thinning, and dual-threshold
% hysteresis, making it more robust and precise than basic gradient methods
% like Sobel or Prewitt.

% - How does Otsu relate to histogram-based thresholding?
% Otsu's method analyzes the image histogram to find a threshold that best
% separates foreground and background by maximizing between-class variance.