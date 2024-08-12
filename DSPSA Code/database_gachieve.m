load meta.mat
% save meta_copy.mat meta
meta_cpy=meta;
for i=setdiff(1:18,[4,6])
    i
    abc=meta{i,2};
    behav=abc.y;
    goals=abc.u(:,1);
%     figure;plot(behav);
%     hold on
%     plot(goals)
%     goal_achiev=behav-goals;
    goal_achiev=behav./goals;
%     figure;plot(goal_achiev)
    
    meta_cpy{i,2}.y=goal_achiev;

    meta_cpy{i,3}.u=meta_cpy{i,2}.u-mean(meta_cpy{i,2}.u);
    meta_cpy{i,3}.y=meta_cpy{i,2}.y-mean(meta_cpy{i,2}.y);

    inp=meta_cpy{i,5};
    l_exp=cell2mat(cellfun(@length,inp.u,'UniformOutput',false));
    datajw=meta_cpy{i,3};
    djw1=datajw(1:l_exp(1));
    djw2=datajw(l_exp(1)+1:l_exp(1)+l_exp(2));
    djw3=datajw(l_exp(1)+l_exp(2)+1:l_exp(1)+l_exp(2)+l_exp(3));
    djw4=datajw(l_exp(1)+l_exp(2)+l_exp(3)+1:l_exp(1)+l_exp(2)+l_exp(3)+l_exp(4));
    djw5=datajw(l_exp(1)+l_exp(2)+l_exp(3)+l_exp(4)+1:end);
    datajw_m=merge(djw1,djw2,djw3,djw4,djw5);
    meta_cpy{i,5}=datajw_m;

end
% meta=meta_cpy;
part=meta_cpy{15,3}
figure;plot(part.y)


% save meta_JW.mat meta_cpy;
