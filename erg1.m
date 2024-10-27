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

function [inverse_F_dct,zeroed_Coefficients] = alter_image(f,threshold)

  F_dct = dct2(f);
  F_dctA = dct2(f);
  zeroed_Coefficients =0;
  %disp(size(F_dct));
  %disp(length(F_dct));
  for u = 1:size(F_dct, 1)
     for v = 1:size(F_dct, 2)
      if abs(F_dct(u,v))< threshold
        F_dct(u,v)=0;
        zeroed_Coefficients+=1;
      endif
     end
  end

  inverse_F_dct =idct2(F_dct);
  inverse_F_dct = uint8(inverse_F_dct);


  for u = 1:size(inverse_F_dct, 1)
     for v = 1:size(inverse_F_dct, 2)
        if inverse_F_dct(u,v) <0
          inverse_F_dct(u,v)=0;
        elseif inverse_F_dct(u,v)>255
          inverse_F_dct(u,v)=255;
        endif
     end
  end
end

function mse = findMeanSquaredError(image,altered_image)
  if size(image)~=size(altered_image)
    return
  endif
  image = double(image);
  altered_image = double(altered_image);
  sumM = 0;
  for x = 1:size(image, 1)
    sumN=0;
    for y = 1:size(image, 2)
      kappa = ((image(x,y))-(altered_image(x,y))^2);
      sumN = sumN + (image(x, y) - altered_image(x, y))^2;
    end
    sumM+=sumN;
  end
  mse =1/(size(image, 1)*size(image, 2))*sumM;
end

function psnr = findPeakSignalToNoiseRatio(mse)
  max_pixel = 255;
  if mse == 0
    psnr = Inf;
  else
    psnr = 10 * log10((max_pixel^2) / mse);
  endif

end
f = imread('C:\Users\Alekos\Desktop\Πολυμεσα\erg1\cameraman.tif');
images ={f};
counter =0;
titles={'Original Image'};
psnr_values={Inf};
zeroedCoefficientsValues = {0};
thresholds = [5, 10, 15];

for i = 1:length(thresholds)
    [inverse_F_dct, zeroed_Coefficients] = alter_image(f, thresholds(i));
    images{end+1} = inverse_F_dct;
    titles{end+1} = sprintf('Altered Image %d', i);
    zeroedCoefficientsValues{end+1} = zeroed_Coefficients;
    mse = findMeanSquaredError(f, inverse_F_dct);
    psnr_values(end+1) = findPeakSignalToNoiseRatio(mse);
end

display_results(images,titles,zeroedCoefficientsValues,psnr_values);



