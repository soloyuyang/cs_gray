                        
function [bestnest,fmin]=cs_fractal(Negn,X)

%% 初始化参数
load data X;
n=30;% Number of nests
pa=0.25;% Discovery rate of alien eggs/solutions
Negn=100; %% Simple bounds of the search domain
nd=6; %%参数个数
Lb=rand/1000+zeros(1,nd); %%下界
Ub=ones(1,nd)-rand/1000;%%上界

%% Random initial solutions
for i=1:n,
    nest(i,:)=Lb+(Ub-Lb).*rand(size(Lb));
end

% Get the current best
for i=1:n
    fitness(i)=fun(nest(i,:));
end
[fmin,bestnest,nest,fitness]=get_best_nest(nest,nest,fitness);

N_iter=0;

%% 迭代寻优
for iter=1:Negn
    % Generate new solutions (but keep the current best)
     new_nest=get_cuckoos(nest,bestnest,Lb,Ub);   
     [fnew,best,nest,fitness]=get_best_nest(nest,new_nest,fitness);%%
    % Update the counter
      N_iter=N_iter+n; 
    % Discovery and randomization
      new_nest=empty_nests(nest,Lb,Ub,pa) ;    
    % Evaluate this set of solutions
      [fnew,best,nest,fitness]=get_best_nest(nest,new_nest,fitness);%%
    % Update the counter again
      N_iter=N_iter+n;
    % Find the best objective so far  
    if fnew<fmin,
        fmin=fnew;
        bestnest=best;
    end
end
%% End of iterations

%% cs优化值作权值进行灰色网络预测

% 参数初始化
a=0.1+bestnest(1)/2;
b1=0.1+bestnest(2)/2;
b2=0.1+bestnest(3)/2;
b3=0.1+bestnest(4)/2;
b4=0.1+bestnest(5)/2;
b5=0.1+bestnest(6)/2;
% 预测误差
error=Greynet1(a,b1,b2,b3,b4,b5)
save error
end


