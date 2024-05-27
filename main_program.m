clc; clear; close all;

% membaca citra asli
Img = imread('tb 01.jpg');
figure, imshow(Img);
title('Citra RGB')

% melakukan segmentasi terhadap citra bakteri TB
[lab,nColors,RGB,segmentedRGB,segmentedbw,cluster_tb] = segmentasi_tb(Img);

% menampilkan citra L*a*b
figure, imshow(lab);
title('Citra L*a*b')

% menampilkan label citra hasil klustering
figure, imshow(RGB,[]), title('Label Citra Hasil Klustering');

% menampilkan objek pada masing2 kluster
for k = 1:nColors
    figure, imshow(segmentedRGB{k}), title(strcat(['Objek Pada Kluster ',num2str(k)]));
end

% menampilkan citra biner hasil segmentasi
figure, imshow(segmentedbw{cluster_tb});
title('Citra Biner Hasil Segmentasi')

% menampilkan citra RGB hasil segmentasi
figure, imshow(segmentedRGB{cluster_tb});
title('Citra RGB Hasil Segmentasi')
