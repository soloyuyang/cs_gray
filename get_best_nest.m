function [fmin,best,nest,fitness]=get_best_nest(nest,newnest,fitness)  %%

% Evaluating all new solutions
for j=1:size(nest,1),
    fnew=fun(newnest(j,:));%%Ŀ�꺯�����Ż�����
    if fnew<=fitness(j),
       fitness(j)=fnew;
       nest(j,:)=newnest(j,:);
    end
end
% Find the current best
[fmin,K]=min(fitness) ;
best=nest(K,:);
end