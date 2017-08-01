% Requires image toolbox.
% Set up for 95 % noise example. Manage directories
% Note that it takes a few minutes at scale = 1. Use scale = 0.125 for
% testing.
clear all
clc
noiseLevel = 95;						% Amount of noise to add, in %
scale = 1;								% Resize source.
I = imread('cat_profile_196806.jpg');	% source image
I=rgb2gray(I);							% Convert to grayscale.
I=imresize(I,scale);
[n,m]=size(I);
Isnp = addSnpNoise(I,noiseLevel);		% Add noise
Ires = snp(Isnp);						% Restore
% Show and save result.
fig=figure;

subplot(3,1,1)
imshow(I)
title(['Source image. Size: ' num2str(n) ' - by - ' num2str(m) ' pixles.'])

subplot(3,1,2)
imshow(Isnp)
title(['Noise added, ' num2str(noiseLevel) ' % pixel data lost'])

subplot(3,1,3)
imshow(Ires)
title('Restored image')

%saveas(fig,'fig.pdf') % Save as pdf if desired.

% Save as bitmaps.
imwrite(I,'I.bmp');
imwrite(Isnp,['Isnp_' num2str(noiseLevel) '_noise.bmp']);
imwrite(Ires,['Ires_' num2str(noiseLevel) '_noise.bmp']);