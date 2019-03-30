function [x_star,f_star,info_iter,xk_iter] = sd_q_bb(A,b,c,x0,eplison)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A,b,c: is the coefficent of objective function
%                   f(x) = 1/2x^TAx+b^Tx + c
% x0: is the initial point of the iterations
% epsilon : is the tolerance of ||g_k||<=epsilon
% x_star: is the minimum of the f(x)
% f_star : is the function value at x_star
% info_iter: is the output informations 

% run by  
% [x,f,info,xk]=sd_q_bb(2*[10,0;0,0.1],[0 0]',0,[1,10]',1e-6)
% [x,f,info,xk]=sd_q_bb(2*[1000,0;0,0.001],[0 0]',0,[1,10000]',1e-6)
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fun = @(x)0.5*x'*A*x+b'*x+c;
gfun = @(x)A*x+b;

f0 = fun(x0);
g0 = gfun(x0)

d0 = -g0;
it = 1;
max_it = 100;
normg = norm(g0);
xk_iter = [x0'];
fk_iter =[f0];
info_iter = [it,f0,normg];
while normg>eplison && it<max_it
    if it ==1
        alpha0 = -(d0'*g0)/(d0'*A*d0);
    else
        alpha0 = (sk'*sk)/(sk'*yk);
        %alpha0 = (sk'*yk)/(yk'*yk);
    end
    sk = alpha0*d0;
    xk = x0 + sk;     xk_iter =[xk_iter;xk'];
    fk = fun(xk);     fk_iter = [fk_iter;fk];
    yk=-g0;
    g0 = gfun(xk);
    yk = yk +g0;
    normg = norm(g0);
    d0 = -g0;
    x0 = xk;
    it = it + 1;
    info_iter = [info_iter;it,fk,norm(g0)];        
end
x_star = xk;
f_star = fk;
figure;
%[Xk1,Xk2]=meshgrid(xk_iter(:,1),xk_iter(:,2));
[Xk1,Xk2]=meshgrid([-10:.5:10],[-10:.5:10]);
Z=0.5*A(1,1)*Xk1.^2 + 0.5*A(2,2)*Xk2.^2 + A(1,2)*Xk1.*Xk2+b(1)*Xk1+b(2)*Xk2+c;
contour(Xk1,Xk2,Z,[0:1:10]);
hold on
plot(xk_iter(:,1),xk_iter(:,2),'-r*');
hold off
figure;
plot(xk_iter(:,1),xk_iter(:,2),'-r*');
end
