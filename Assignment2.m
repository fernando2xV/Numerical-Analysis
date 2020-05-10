clear;
close all;

%TASK 1
raw_data = xlsread('muscle_data_2017.xlsx');
strain = raw_data(:, 3);
stress = raw_data(:, 4);


%TASK 2
N = length(strain);
error = zeros(5, 1);

for i = 1 : 5 
    p = polyfit(strain, stress, i);
    stress_estimate = polyval(p, strain);
    error(i) = immse(stress, stress_estimate);
    
end 
    
i = 1:5;

%TASK 3
p3 = polyfit(strain, stress, 3);
stress_3 = polyval(p3, strain);

%TASK 4
error_b = stress - stress_3;
m = length(strain);
Std_dev = std(error_b);
Std_error = Std_dev / sqrt(m);
Corr = corrcoef(error_b);


%TASK 5
a = [0.3;0.3;0.3];
est_stress = 1 - (a(1) * (exp(a(2) * strain))) - a(3);
coefs = fminsearch(@(a) Assignment2_func(a, strain, stress), [0.3;0.3;0.3]);
est_stress_abs = 1 - (coefs(1) * exp(coefs(2) * strain)) - coefs(3);

%TASK 6
error_c = stress - est_stress_abs;
p = length(strain);
Std_dev_2 = std(error_c);
Std_err_2 = Std_dev_2 / sqrt(p);
Corr_2 = corrcoef(error_c);

figure(1);
plot(strain, stress, 'b-', 'Linewidth', 3);
ylabel('Stress (kPa)', 'Fontsize', 24);
xlabel('Strain', 'Fontsize', 24);
title('Stress vs Strain', 'Fontsize', 24);
hold on;
plot(strain, stress_3, 'r-', 'Linewidth', 2);
plot(strain, est_stress_abs, 'k--', 'linewidth', 2);
hold off;

figure(2);
plot (i, error);
xlabel('Model orders', 'Fontsize', 24);
ylabel('Square error', 'Fontsize', 24);
title('Error vs Model order', 'Fontsize', 24);

figure(3);
histogram(error_b);
xlabel('Error in polynomial fit');
ylabel('Frequency');
X = ['Std error = ', num2str(Std_error), ' r = ', num2str(Corr)];
title(X);
ylim([0 70]);

figure(4);
histogram(error_c);
xlabel('Error in polynomial fit');
ylabel('Frequency');
Y = ['Std error = ', num2str(Std_err_2), ' r = ', num2str(Corr_2)];
title(Y);
ylim([0 60]);






