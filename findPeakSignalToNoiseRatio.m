


function psnr = findPeakSignalToNoiseRatio(originalImage,reconstructedImage)
  mse = findMeanSquaredError(originalImage, reconstructedImage);
  max_pixel = 255;
  if mse == 0
    psnr = Inf;
  else
    psnr = 10 * log10((max_pixel^2) / mse);
  endif
end

function mse = findMeanSquaredError(originalImage,reconstructedImage)
  if size(originalImage)!=size(reconstructedImage)
    return
  endif
  originalImage = double(originalImage);
  reconstructedImage = double(reconstructedImage);
  sumM = 0;
  for x = 1:size(originalImage, 1)
    sumN=0;
    for y = 1:size(originalImage, 2)
      sumN = sumN + (originalImage(x, y) - reconstructedImage(x, y))^2;
    end
    sumM+=sumN;
  end
  mse =1/(size(originalImage, 1)*size(originalImage, 2))*sumM;
end


