

classdef findPeakSignalToNoiseRatio
  properties
    originalImage;
    reconstructedImage;
  end
  methods
    function obj = findPeakSignalToNoiseRatio(originalImage, reconstructedImage)
      obj.originalImage = double(originalImage);
      obj.reconstructedImage = double(reconstructedImage);
    end

    function psnr = calculatePSNR(obj)
      mse = obj.findMeanSquaredError();
      max_pixel = 255;
      if mse == 0
        psnr = Inf;
      else
        psnr = 10 * log10((max_pixel^2) / mse);
      endif
    end

    function mse = findMeanSquaredError(obj)
      if size(obj.originalImage)!=size(obj.reconstructedImage)
        error('Images must be of the same size.');
      endif
      sumM = 0;
      for x = 1:size(obj.originalImage, 1)
        sumN=0;
        for y = 1:size(obj.originalImage, 2)
          sumN = sumN + (obj.originalImage(x, y) - obj.reconstructedImage(x, y))^2;
        end
        sumM+=sumN;
      end
      mse =1/(size(obj.originalImage, 1)*size(obj.originalImage, 2))*sumM;
    end
  end
end
