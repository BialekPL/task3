%Grupa Bereta, Białecki, Fatyga
%% Task3A
obraz1 = imread('dapi.tif');
obraz_szary = rgb2gray(obraz1);
[output_image, liczba_jader, binarna_maska, centroidy] = nuclei_counter(obraz_szary);
binarna_maska = imfill(binarna_maska, 'holes');
figure(1)
subplot(1,2,1)
imshow(obraz1);title("Obraz oryginalny");
subplot(1,2,2)
imshow(binarna_maska);title("Binarna maska DAFI");
figure(2);
imshow(output_image);title("Zaznaczone wykryte jądra")
% wyświetlenie czarnego tła a na nim centroidy
black(length(obraz1), length(obraz1(:,1))) = 0;
figure(3);
imshow(black);title("centroidy");
hold on
centroidy1 = cat(1, centroidy.Centroid);
plot(centroidy1(:,1), centroidy1(:,2), 'w.');
hold off

%Wyświetlenie oryginału a na nim mapa gęstości
centroidy2 = vertcat(centroidy.Centroid);
[bandwidth,density,X,Y] = kde2d(centroidy2);
figure(4); 
imshow(obraz1);title("mapa gęstości")
hold on;
contour(X,Y,density,50);
hold off;

%% Task3B
obraz2 = imread("oran.tif");
binaryzacja = imbinarize(obraz2, 'global');
binaryzacja = binaryzacja(:,:,1);
binaryzacja = imfill(binaryzacja, 'holes');
dylacja = imdilate(binaryzacja, strel('disk',6,4));
figure(5);imshow(dylacja)
figure(6);imshow(dylacja - binaryzacja)

