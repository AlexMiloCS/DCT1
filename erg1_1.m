pkg load image
pkg load signal

function display_results(images,titles,zeroedCoefficientsValues,psnr_values)
  num_images = length(images);
  num_cols = ceil(sqrt(num_images));
  num_rows = ceil(num_images / num_cols);

  figure;
  colormap(gray);
   for i = 1:num_images
        subplot(num_rows, num_cols, i);
        imagesc(images{i});
        axis image;
        title(titles{i});
        annotationText = sprintf('zeroed Coefficients %d , PSNR %d', zeroedCoefficientsValues{i},psnr_values{i});
        text(0.5, -0.25, annotationText, 'Units', 'normalized', ...
         'HorizontalAlignment', 'center', 'FontSize', 10, 'Color', 'black');
    end
end

function [reconstructedImage,zeroedCoefficients] = reconstruct_image(f,threshold)

  F_dct = dct2(f);
  zeroedCoefficients =0;
  for u = 1:size(F_dct, 1)
     for v = 1:size(F_dct, 2)
      if abs(F_dct(u,v))< threshold
        F_dct(u,v)=0;
        zeroedCoefficients+=1;
      endif
     end
  end

  reconstructedImage=idct2(F_dct);
  reconstructedImage = uint8(reconstructedImage);


  for u = 1:size(reconstructedImage, 1)
     for v = 1:size(reconstructedImage, 2)
        if reconstructedImage(u,v) <0
          reconstructedImage(u,v)=0;
        elseif reconstructedImage(u,v)>255
          reconstructedImage(u,v)=255;
        endif
     end
  end
end

f = imread('C:\Users\Alekos\Desktop\Πολυμεσα\erg1\cameraman.tif');
images ={f};
titles={'Original Image'};
psnr_values={Inf};
zeroedCoefficientsValues = {0};
thresholds = [5, 10, 15];

for i = 1:length(thresholds)
    [reconstructedImage, zeroedCoefficients] = reconstruct_image(f, thresholds(i));
    images{end+1} = reconstructedImage;
    titles{end+1} = sprintf('Altered Image %d', i);
    zeroedCoefficientsValues{end+1} = zeroedCoefficients;
    psnr_values(end+1) = findPeakSignalToNoiseRatio(f, reconstructedImage);
end

display_results(images,titles,zeroedCoefficientsValues,psnr_values);



