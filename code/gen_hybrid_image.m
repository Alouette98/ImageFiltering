function [hybrid_image,low_frequencies,high_frequencies] = gen_hybrid_image( image1, image2, cutoff_frequency )
% Inputs:
% - image1 -> The image from which to take the low frequencies.
% - image2 -> The image from which to take the high frequencies.
% - cutoff_frequency -> The standard deviation, in pixels, of the Gaussian 
%                       blur that will remove high frequencies.
%
% Task:
% - Use my_imfilter to create 'low_frequencies' and 'high_frequencies'.
% - Combine them to create 'hybrid_image'.
cutoff_frequency1=5;
cutoff_frequency2=5;
filter1 = fspecial('Gaussian', cutoff_frequency1*4+1, cutoff_frequency1);
filter2 = fspecial('Gaussian', cutoff_frequency2*4+1, cutoff_frequency2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the high frequencies from image1 by blurring it. The amount of
% blur that works best will vary with different image pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
low_source = im2single(imread('../data/marilyn.bmp'));
low_filtered = my_imfilter(low_source, filter1);
low_frequencies = low_filtered;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the low frequencies from image2. The easiest way to do this is to
% subtract a blurred version of image2 from the original version of image2.
% This will give you an image centered at zero with negative values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
high_source = im2single(imread('../data/einstein.bmp'));
high_filtered = my_imfilter(high_source,filter2);
high_frequencies = high_source - high_filtered;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hybrid_image= high_frequencies+low_frequencies;
vis = vis_hybrid_image(hybrid_image);
figure;
imshow(vis);
