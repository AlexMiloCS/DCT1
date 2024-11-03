pkg load image
pkg load signal



f = imread('C:\Users\Alekos\Desktop\Πολυμεσα\erg1\cameraman.tif');
images ={f};
titles={'Original Image'};
psnr_values={Inf};
zeroedCoefficientsValues = {0};



thresholds = [5, 10, 15];

for i = 1:length(thresholds)
  threshold = thresholds(i);
  recon = reconstructImage(f);
  [reconstructedImage, zeroedCoefficients] = recon.reconstructByThreshold(threshold);
  images{end+1} = reconstructedImage;
  titles{end+1} = sprintf('Altered Image %d', i);
  zeroedCoefficientsValues{end+1} = zeroedCoefficients;
  psnrCalculator = findPeakSignalToNoiseRatio(f, reconstructedImage);
  psnrValue = psnrCalculator.calculatePSNR();
  psnr_values(end+1) = psnrValue;
end

result = displayResults(images,titles,psnr_values,'zeroed Coefficients');
result.displayPart1(zeroedCoefficientsValues);


