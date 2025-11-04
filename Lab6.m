%% Lab 6: Mini Project – Your Image Pipeline
% This lab builds a full image processing pipeline using spatial and frequency domain techniques.
close all;
clear;
clc;

% 1) Load your own image (object, face, landscape, etc.)
% Convert to grayscale and normalize to [0,1]
I = im2double(rgb2gray(imread('Clyde.jpg')));

% 2) Pre-process: noise removal
% Apply median filter to reduce impulse noise while preserving edges
I_filt = medfilt2(I,[3 3]);

% 3) Enhance contrast
% Stretch intensity range to improve visibility of features
I_enh = imadjust(I_filt,[0.2 0.8],[0 1]);

% 4) Extract features (edges or frequency)
% Use Canny edge detector for clean, thin edge extraction
edges = edge(I_enh,'Canny',[0.1 0.25]);

% 5) Optional frequency-domain mask
% Apply circular low-pass filter in frequency domain to smooth image
F = fftshift(fft2(I_enh));
[M,N] = size(F);
[u,v] = meshgrid(-N/2:N/2-1,-M/2:M/2-1);
H = double(sqrt(u.^2+v.^2)<60); % Circular mask
I_lp = real(ifft2(ifftshift(F.*H)));

% 6) Visualization
% Show each stage of the pipeline for comparison
figure;
montage({I, I_filt, I_enh, edges, I_lp},'Size',[1 5]);
title('Original | Denoised | Enhanced | Edges | LP result');

%% 7) Report
% - Describe your processing pipeline.
%   → The image is first denoised with a median filter, then contrast-enhanced.
%      Edges are extracted using Canny, and a low-pass filter is applied in the frequency domain.

% - Explain how each stage relates to DSP operations.
%   → Median filtering is a non-linear spatial filter.
%      Contrast stretching is a point-wise transformation.
%      Canny edge detection combines smoothing, gradient filtering, and thresholding.
%      FFT-based low-pass filtering removes high-frequency components.

% - Discuss improvements or limitations.
%   → Limitations: fixed thresholds may miss weak edges; low-pass filtering may oversmooth.
%     Improvements: use adaptive edge thresholds, try band-pass filters, or add segmentation.