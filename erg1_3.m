pkg load image
pkg load signal


function level_run_pairs = level_run_toEncrypt(ac_Coefficients)
    level_run_pairs = [];
    run = 0;
    for i = 1:length(ac_Coefficients)
      currentCoefficient = ac_Coefficients(i);
      if currentCoefficient==0
        run =run +1;
      else
        level_run_pairs = [level_run_pairs; currentCoefficient , run];
        run = 0;
      end
    end
end

AC_coefficients = [7, 0, 4, 0, 2, 3, 0, 0, 2, 4, 0, 1, 0, 0, 0, 1, 0, 0, -1, -1, 0, 1, 0, 0, 0, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
level_run_pairs=level_run_toEncrypt(AC_coefficients);
disp(level_run_pairs);
