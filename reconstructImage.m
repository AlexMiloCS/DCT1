
classdef reconstructImage
  properties
    image;
  end
  methods
    function obj = reconstructImage(image)
      obj.image=image;
    end

    function [reconstructedImage,zeroedCoefficients] = reconstructByThreshold(obj,threshold)
      F_dct = dct2(obj.image);
      zeroedCoefficients =0;
      for u = 1:size(F_dct, 1)
        for v = 1:size(F_dct, 2)
          if abs(F_dct(u,v))< threshold
            F_dct(u,v)=0;
            zeroedCoefficients+=1;
          end
        end
      end
      reconstructedImage=idct2(F_dct);
      reconstructedImage = obj.makeImageUInt8(reconstructedImage);
    end

    function [reconstructedImage,myEntropy] =reconstructByQuantization(obj,Q)
      myQuantization = quantization(obj.image,Q);
      [reconstructedImage,myEntropy] = myQuantization.computeBlocks();
      reconstructedImage = obj.makeImageUInt8(reconstructedImage);
    end

    function reconstructedImage = makeImageUInt8(obj,reconstructedImage)
      for u = 1:size(reconstructedImage, 1)
        for v = 1:size(reconstructedImage, 2)
          if reconstructedImage(u,v) <0
            reconstructedImage(u,v)=0;
          elseif reconstructedImage(u,v)>255
            reconstructedImage(u,v)=255;
          endif
        end
      end
      reconstructedImage = uint8(reconstructedImage);
    end

  end
end


