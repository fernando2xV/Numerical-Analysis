%Script for comparing Numerical and Analytic Solutions
clear;
close all;

%Define known variables
g = 10; c = 12.5; m = 70;

%Define timestep
delta_t = 1.0;

%Define time vector containing time instants starting from 0
%in increments of delta_t
t = 0:delta_t:20;

%Calculate the analytic velocity solution
v_analytic = (m*g)/c*(1-exp(-(c*t)/m));
    
%Now plot that
figure(1);
h = plot(t, v_analytic, 'b-');
grid on;
set(h,'linewidth',2.0);
xlabel('Time (sec)', 'fontsize', 24);
ylabel('Velocity (m/s)', 'fontsize', 24);
title('The Analytic Solution');


%Calculate numerical solution
%First set up N (the number of iterations)
% and the array for the numerical results
N = length(t);
v_numerical = zeros(N,1);
%
% Numerical iteration code goes here
%

for i=2:N
    v_numerical(i)=v_numerical(i-1)+((g-(c*v_numerical(i-1))/m)*0.5);
    
end

%Now plot the two solutions on the same plot
figure(2);
h = plot(t, v_analytic, 'green', t, v_numerical, 'red');
grid on;
set(h,'linewidth',2.0);
xlabel('Time (sec)', 'fontsize', 24);
ylabel('Velocity (m/s)', 'fontsize', 24);
title('Comparing Numerical and Analytic Solutions');

% Now figure out the error at t = 1 sec and t = 9 sec
% You may do this graphically
% But its better to do it using the data you have just
% calculated in Matlab. Use some code.
error2=v_analytic(2)-v_numerical(2);
error10=v_analytic(10)-v_numerical(10);
abs(error2)
abs(error10)

error4 = abs(v_analytic - v_numerical)
e1 = error4(2)
e2 = error4(10)