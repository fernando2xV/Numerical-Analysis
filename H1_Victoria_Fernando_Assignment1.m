clear;
close all;
jumpdata = csvread('RedBullJumpData.csv');
t_redbull = jumpdata(:,1);
v_redbull = jumpdata(:,2);
terminal_velocity = jumpdata(:,3);
N_timestamps = length(t_redbull);

%TASK 1.
%Red line with crosses.
figure(1);
plot(t_redbull,v_redbull,'r-X');
grid on;
xlabel('Time (s)','Fontsize',24);
ylabel('Velocity (m/s)','Fontsize',24);
title('First graph');

hold on;
%TASK 2.
%Blue line superimposed on graph.
hold on;
a=9.81;
t=t_redbull;
v=a*t;
plot(t_redbull,v,'b--');
ylim([0 400]);
xlim([0 180]);

%TASK 3.
error_percentage=(v-v_redbull)./v;
t_index=min(find(error_percentage>.05));

fprintf('Mr.B. enters the earth’s atmosphere at %d secs after he jumps.',t_redbull(t_index));
fprintf('\n');
fprintf('\n');


%TASK 4.
t_green=56:1:180;
g=9.81;
c=3;
m=60;
dt=1;
N = length(t_redbull);

while (t_redbull(dt,1)<56)
dt=dt+1;
end

v_numerical=zeros(38,1);

for i=1:dt-1 %First terms till dt-1 are the same as the v_redbull, the second loop deals with the rest.
v_numerical(i,1) = v_redbull(i,1);
end


for i=dt-1:N-1
v_numerical(i+1,1) = v_numerical(i,1)+(g-c*v_numerical(i,1)/m)*(t_redbull(i+1, 1)-t_redbull(i,1));
end
plot(t_redbull,v_numerical,'g--');

%TASK 5.
time64=1;
while (t_redbull(time64,1)<64)
time64=time64+1;
end
errort64 = v_numerical(time64,1) - v_redbull(time64,1);


q=(errort64/v_redbull(time64,1))*100;
 %Not doing absolute value because the error that we should get, as the demonstrator indictaed, was negative.



time170=1;

while (t_redbull(time170,1)<170)
time170=time170+1;
end
errort170 = v_numerical(time170,1) - v_redbull(time170,1);


p=(errort170/v_redbull(time170,1))*100;
disp("The percentage error at 64 and 170 seconds is "+q+"% and "+p+"% respectively.");

%TASK 6.
tol = 0.3; 
t_init = 64; 
precision = 0.001;
Num_iteration = (5/60 - 2/60)/ precision;
round(Num_iteration);
v_redbull64s = 290;
v_redbull69s = 260; 
v_new = zeros(50, 3); 
v_new(:, 1) = v_redbull64s;
index = 20;
k_new = 2/60;
    for row = 1:50         
            for i = 1:2
                v_new(row,i+1) = v_new(row,i) + (g - (k_new * v_new(row, i))) * (t_redbull(index+1) - t_redbull(index));
                index = index + 1;
            end
            index = 20;
            k_new = k_new + precision;
    end
    
v_new_diff = abs(v_new(:,3) - v_redbull69s);

counter =1;
for i = 1:50
    if ((v_new_diff(i)/v_redbull69s)) * 100 <= tol
       disp("The value of c/m is " + (2/60 + precision * i));
       z=(v_new_diff(i)/v_redbull69s)*100;
       cOverM=(2/60 + precision * i);
    end
end
t_black=64:1:180;
T=length(t_black);
v_black=zeros(T,1);

dt=1;
g=9.81;


for f=2:T
    v_black(1)=290;
    v_black(f)=v_black(f-1)+(g-((cOverM)*v_black(f-1)))*(dt);
end

plot(t_black,v_black,'k--');
disp("The percentage error at 69 secs is "+z+"%");



