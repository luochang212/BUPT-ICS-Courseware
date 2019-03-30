function [f] = myrosenbrock(x)
f = 100*(x(2)-x(1)^2)^2+(1-x(1))^2;
