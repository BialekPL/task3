% this is just an example to show how to use this function

% read an image
I = imread('img01.JPG');

% convert it to grayscale of just take one channel
% Igray = rgb2gray(I);
Iblue = I(:,:,3);

% call the nuclei counter function
[outputImage, number_of_nuclei] = nuclei_counter(Iblue);