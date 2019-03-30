function [x,f,k,xiter]=QuasiNewton(fun,x0,epsilon)
%---------------------------------------------------------
% 拟牛顿法求解 min f(x)
% fun 计算函数
% x0 初始迭代点
% epsilon 允许误差
%　ｘ最优值点
%  f 最优值
%  k 迭代次数
% 调用： 
%[x,f,k,xiter]=QuasiNewton(@fun,[0,0]',0.001)
%[x,f,k,xiter]=QuasiNewton(@myrosenbrock,[0,0]',0.001)
%-------------------------------------------------------


k=0;  % 迭代次数
rho=0.9;
beta=0.5;
tau=1;
nmax = 100;%不能设置太大
mmax=30;
xiter=[x0' feval(fun,x0)];

syms a b
F = fun([a,b]);
v=[a,b];
grad=jacobian(F,v); %求梯度

Hk=eye(2);% 初始的矩阵

while (k<nmax)
    
    gk=subs(grad,v,x0');%
    
    if norm(gk)<epsilon    
        break;     %一阶必要性条件
    end
    
    
    dk= -Hk*(gk'); 
    m=0;  %　线搜索用Ａｒｍｉｊｏ准则
          %   Wolfe 搜索准则
    while (m<mmax)
        if feval(fun,(x0+(beta^m*tau*dk)))<feval(fun,x0)+(rho*beta^m*tau*dk'.*gk)
            break;
        end
        m=m+1;
    end
    mk=m;  
    x1=x0+(beta^mk*tau*dk);
    
    sk = x1 - x0;
    
    yk = subs(subs(grad,a,x1(1)),b,x1(2)) - subs(subs(grad,a,x0(1)),b,x0(2));
    yk=yk';
    
    %DFP 方法
    Hk = Hk - (Hk*yk*yk'*Hk)./(yk'*Hk*yk)+(sk*sk')/(yk'*sk);
    
    x0=x1;
    
    f=feval(fun,x0);
    xiter=[xiter;x0' f];
    k=k+1;
end
x=x0;
%f=feval(fun,x0);
%plot3(xiter(:,1),xiter(:,2),xiter(:,3),'r*')
end
