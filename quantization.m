

classdef quantization
  properties
    Q;
    image;
  end
  methods
    function obj = quantization(image,Q)
      obj.Q = double(Q);
      obj.image=image;
    end

    function [dequantizedBlocks,myEntropy] = computeBlocks(obj)
      blockSize = size(obj.Q);
      [rows,cols] = size(obj.image);
      quantizedBlocks = [];
      dequantizedBlocks = [];
      for u = 1:blockSize(1):rows
        for v = 1:blockSize(2):cols
          rowEnd = u + blockSize(1) - 1;
          colEnd = v + blockSize(2) - 1;
          block = obj.image(u:rowEnd, v:colEnd);
          quantizedBlock = obj.quantize(block);
          quantizedBlocks(u:rowEnd , v:colEnd) = quantizedBlock;
          dequantizedBlock = obj.dequantize(quantizedBlock);
          dequantizedBlocks(u:rowEnd , v:colEnd) = dequantizedBlock;
        end
      end
      quantizedBlocks = abs(quantizedBlocks);
      myEntropy= entropy(quantizedBlocks);
    end

    function quantizedBlock= quantize(obj,block)
      block = double(block);
      dctBlock = dct2(block);
      quantizedBlock = round(dctBlock ./ obj.Q);
    end

    function dequantizedBlock = dequantize(obj,block)
      block = double(block);
      dequantizedBlock = block .* obj.Q;
      dequantizedBlock =idct2(dequantizedBlock);
    end


  end
end



