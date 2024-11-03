pkg load image
pkg load signal


f = imread('C:\Users\Alekos\Desktop\Πολυμεσα\erg1\cameraman.tif');
image_entropy = entropy(f);
Q = [
    16 11 10 16 24 40 51 61;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99
];

images ={f};
titles={'Original Image'};
psnr_values={Inf};
entropyValues = {image_entropy};

qValues = [1, 2, 4];

for i=1:length(qValues)
  Q=Q*qValues(i);
  recon = reconstructImage(f);
  [reconstructedImage, entropyValue] = recon.reconstructByQuantization(Q);
  images{end+1} = reconstructedImage;
  entropyValues{end+1} = entropyValue;
  titles{end+1} = sprintf('Altered Image %d', i);
  psnrCalculator = findPeakSignalToNoiseRatio(f, reconstructedImage);
  psnrValue = psnrCalculator.calculatePSNR();
  psnr_values(end+1) = psnrValue;
end

result = displayResults(images,titles,psnr_values,'entropy');
result.displayPart1(entropyValues);
