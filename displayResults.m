classdef displayResults
  properties
    images;
    titles;
    psnr_values;
    displayValuesId;
  end
  methods
    function obj = displayResults(images,titles,psnr_values,displayValuesId)
      obj.images = images;
      obj.titles = titles;
      obj.psnr_values = psnr_values;
      obj.displayValuesId = displayValuesId;
    end

    function displayPart1(obj,displayValues)
      num_images = length(obj.images);
      num_cols = ceil(sqrt(num_images));
      num_rows = ceil(num_images / num_cols);

      figure;
      colormap(gray);
      for i = 1:num_images
        ax = subplot(num_rows, num_cols, i);
        subplot(num_rows, num_cols, i);
        imagesc(obj.images{i});
        axis image;
        title(obj.titles{i});
        annotationText = sprintf('%s: %0.2f, PSNR: %0.2f', obj.displayValuesId, displayValues{i}, obj.psnr_values{i});
        if num_rows > 1
           textYPosition = -0.1 - (0.1 * (num_rows - 1));  % Adjust Y position based on rows
        else
          textYPosition = -0.25;  % Default position for single row
        end
        text(0.5, textYPosition, annotationText, 'Units', 'normalized', ...
         'HorizontalAlignment', 'center', 'FontSize', 10, 'Color', 'black');;
      end
    end
  end
end








