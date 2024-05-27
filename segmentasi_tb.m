function [lab,nColors,RGB,segmentedRGB,segmentedbw,cluster_tb] = segmentasi_tb(Img)

% transformasi ruang warna RGB ke ruang warna L*a*b
cform = makecform('srgb2lab');
lab = applycform(Img,cform);

% mengekstrak komponen a dan b
ab = double(lab(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

% melakukan segmentasi citra menggunakan algoritma k-means clustering
nColors = 3;
[idx, C] = kmeans(ab,nColors);

% menampilkan plot grafik hasil klustering 
h = figure;
h.Color = 'w';
plot(ab(idx==1,1),ab(idx==1,2),'r.','MarkerSize',24)
hold on
grid on
plot(ab(idx==2,1),ab(idx==2,2),'g.','MarkerSize',24)
plot(ab(idx==3,1),ab(idx==3,2),'b.','MarkerSize',24)
plot(C(:,1),C(:,2),'kx',...
    'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster 3','Centroids',...
    'Location','best')
title('Cluster Assignments and Centroids')
xlabel('a')
ylabel('b')
hold off

% melakukan pelabelan terhadap citra hasil klustering
pixel_labels = reshape(idx,nrows,ncols);
RGB = label2rgb(pixel_labels);

% membaca citra hasil klustering
segmentedRGB = cell(1,3);
segmentedbw = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);
area_cluster = zeros(1,1,nColors);

for k = 1:nColors
    color = Img;
    color(rgb_label ~= k) = 0;
    bw = (pixel_labels==k);
    area_cluster(:,:,k) = sum(bw(:));
    segmentedRGB{k} = color;
    segmentedbw{k} = bw;
end

% mencari kluster TB
[~, cluster_tb] = min(area_cluster);

