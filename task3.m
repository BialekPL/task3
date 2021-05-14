obraz1 = imread('dapi.tif');
obraz_szary = rgb2gray(obraz1);
[output_image, liczba_jader, binarna_maska, centroidy] = nuclei_counter(obraz_szary);
binarna_maska = imfill(binarna_maska, 'holes');
figure(1)
subplot(1,2,1)
imshow(obraz1);title("Obraz oryginalny");
subplot(1,2,2)
imshow(binarna_maska);title("Binarna maska DAFI");

black(length(obraz1), length(obraz1(:,1))) = 0;

figure(2);title("centroidy");
imshow(black);
hold on
plot(centroidy(:,1), centroidy(:,2), 'w.');
hold off

[bandwidth,density,X,Y] = kde2d(centroidy, 2^5);
figure(3)
imshow(obraz1);
hold on;
contour(X,Y,density,50);
hold off;
