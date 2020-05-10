clear;
close all;

load('forcing.mat');
load('badpicture.mat');
mask = double(imread('badpixels.tif'));
original = double(imread('greece.tif'));

figure(1);

colormap(gray(256));
image(imread('greece.tif'));
title('Original image');

figure(2);

colormap(gray(256));
image(badpic);
title('Corrupted image');

new_picture = badpic;

[i,j] = find(mask == 1);

N = length(j);

alpha = 1;

std_error = zeros(1, 2000);
my_error = zeros(1, N);
orig = zeros(1, N);

for iterations = 1:2000
    
    myerror = 0;
    
    for k = 1:N

        I_xlast = new_picture(i(k), (j(k) - 1));
        I_xnew = new_picture(i(k), (j(k) + 1));
        I_ylast = new_picture((i(k) - 1), j(k));
        I_ynew = new_picture((i(k) + 1), j(k));
        I_current = new_picture(i(k), j(k));

        error = I_xlast + I_ylast + I_xnew + I_ynew - (4 * I_current);
        
        new_picture(i(k), j(k)) = I_current + (alpha + (0.0005 * iterations)) * error/4;
        
        my_error(k) = new_picture(i(k), j(k));
        
        orig(k) = original(i(k), j(k));
        
    end
    std_error(iterations) = std(my_error - orig);
end


figure(3);

colormap(gray(256));
image(new_picture);
title('Restored Picture');
new_pic_force = badpic;
std_error_force = zeros(1, 2000);
my_error_force = zeros(1, N);


for iterations = 1:2000   
    for k = 1:N
        
        I_ylast = new_pic_force(i(k), (j(k) - 1));
        I_ynew = new_pic_force(i(k), (j(k) + 1));
        I_xlast = new_pic_force((i(k) - 1), j(k));
        I_xnew = new_pic_force((i(k) + 1), j(k));
        I_current = new_pic_force(i(k), j(k));
        forcing = f(i(k), j(k));
         
        error_force = I_xlast + I_ylast + I_xnew + I_ynew - (4 * I_current) - forcing;
        new_pic_force(i(k), j(k)) = I_current + (alpha + (0.0005 * iterations)) * error_force/4;         
        
        my_error_force(k) = new_pic_force(i(k), j(k));
    end 
    std_error_force(iterations) = std(my_error_force - orig);
end


figure(4);

colormap(gray(256));
image(new_pic_force);
title('Restored Picture with F');

figure(5);
plot(std_error, 'r-', 'linewidth', 3);
xlabel('Iterations', 'fontsize', 14);
ylabel('Std error', 'fontsize', 14);
hold on;

plot(std_error_force, 'b-', 'linewidth', 3);
legend('Without forcing function', 'With forcing function');
hold off;





