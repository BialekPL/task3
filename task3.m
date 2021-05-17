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
imshow(obraz1);title("mapa gęstości wszystkich komórek")
hold on;
contour(X,Y,density,50);
hold off;

%% Task3B
obraz2 = imread("oran.tif");
obraz2 = obraz2(:,:,1);
binaryzacja = imbinarize(obraz2, 'global');
binaryzacja = binaryzacja(:,:,1);
binaryzacja = imfill(binaryzacja, 'holes');
binaryzacja = bwareaopen(binaryzacja, 20);
dylacja = imdilate(binaryzacja, strel('disk',8,4));
ringi = dylacja - binaryzacja;
figure(5);imshow(ringi); title("ringi")
limfocyty = zeros(3433,3488);

%dla każdego piksela, jeśli otoczenie w dapi+ring jest intesywniejsze niż
%otoczenie w samym dapi, to wyświetlany jest piksel z dapi. Jeśli nie,
%wyświetlany jest czarny piksel
dapi_i_ringi = obraz_szary + uint8(ringi);
dir = dapi_i_ringi;
for i = 2:3432
    for j = 2:3487
        otoczenie_dir = dir(i-1,j-1) + dir(i-1, j) + dir(i-1, j+1) + dir(i,j-1 ) + dir(i, j) + dir(i, j+1) + dir(i+1, j-1) + dir(i+1, j) + dir(i+1, j+1);
        otoczenie_dapi = obraz_szary(i-1,j-1) + obraz_szary(i-1, j) + obraz_szary(i-1, j+1) + obraz_szary(i,j-1 ) + obraz_szary(i, j) + obraz_szary(i, j+1) + obraz_szary(i+1, j-1) + obraz_szary(i+1, j) + obraz_szary(i+1, j+1);
        if otoczenie_dir > otoczenie_dapi
            limfocyty(i,j) = obraz_szary(i,j);
        end
    end
end

limfocyty_wypelnione = imfill(limfocyty);
limfocyty_oczyszczone = bwareaopen(limfocyty_wypelnione, 60);
figure(6);imshow(limfocyty_oczyszczone);title("Maska binarna limfocytów uzyskana z obrazu DAPI");

% przekształcenie do rgb by heatmapa wyświetlała się w kolorze
limfocyty_rgb = cat(3, limfocyty_wypelnione, limfocyty_wypelnione, limfocyty_wypelnione);

[output_image2, liczba_jader2, binarna_maska2, centroidy3] = nuclei_counter((im2gray(obraz2)));
centroidy4 = vertcat(centroidy3.Centroid);
[bandwidth2,density2,X2,Y2] = kde2d(centroidy4);
figure(7); 
imshow(limfocyty_rgb);title("mapa gęstości limfocytów CD8")
hold on;
contour(X,Y,density2,50);
hold off;