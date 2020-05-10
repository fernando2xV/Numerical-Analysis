function [f]= Assignment2_func(a,strain,stress)
estimated=1-(a(1)*exp(a(2)*strain))-a(3);
e=stress-estimated;
f=sum(abs(e));
end