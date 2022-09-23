%%
% clear all of the variable
clear all

%%
% This demo I take step and 8 as example. 
% image read : txt. file :)
% the file is name by yourself, here I name it 'zoom_in .. step sobel'
fimg_bas = fopen('zoom_in_1_step sobel.txt') ;
image_raw_bas = textscan(fimg_bas,'%f') ;

bas_size = sqrt(size(image_raw_bas{1,1}))
% This kernel set as basis 
imagemat_bas  = reshape(image_raw_bas{1,1},bas_size(1),bas_size(1)) ;


%%
% Here goes the comparing image data
% Everytime change data reset from this block diagram.

fimg = fopen('zoom_in_10_step sobel.txt')   ;
image_raw = textscan(fimg,'%f') ;

comp_size = sqrt(size(image_raw{1,1}))
imagemat_comp_raw = reshape(image_raw{1,1},comp_size(1),comp_size(1)) ;

%%
clear image_raw_bas image_raw

%%
% Here goes the cross correlation for the two data: basis and the
% comparision

correlation_matrix = xcorr2(imagemat_comp_raw,imagemat_bas)

%%

[ a ind1 ] = max(correlation_matrix);
[ b ind2 ] = max(max(correlation_matrix))

% the above is to find the column and row to adjust the wanted placement.


%%
% once the location is founded, try to plug it back to the origianl basis
% matrix :))

imagesc(islocalmax(correlation_matrix))

%%
% Here calculate the column and row that one will adjust the position of the two
% text image. I choose to add row and column to the compared matrix data.
% Maximum located at :


add_x_1 = zeros(comp_size(1),bas_size(1)-ind2)
add_x_2 = zeros(comp_size(1),ind2-comp_size(1))


imagemat_com_test = [ add_x_1 imagemat_comp_raw add_x_2 ]

add_y_1 = zeros(bas_size(1)-ind1(1,ind2),bas_size(1))
add_y_2 = zeros(ind1(1,ind2)-comp_size(1),bas_size(1))

imagemat_com_test = [ add_y_1 ; imagemat_com_test ; add_y_2 ]

%% 

% This imagesc test for whether the position is corrected. 
imagesc(imagemat_com_test)

%%
% This part is to compare the two image's different.

image_cal = imagemat_com_test/255 + imagemat_bas/255*2 
imagesc(image_cal)
xlim([50 300])
ylim([50 300])
title('1 and 10 Step Image Comparision','Interpreter','latex')


