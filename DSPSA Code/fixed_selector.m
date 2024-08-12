load meta.mat


fit_percent_overall=[];
fit_percent_valdat=[];
fit_percent_valdat1=[];
fit_percent_estall=[];
order_matrix=[];
model_matrix={};
fvc=[];
fvc2=[];
fec=[];
fec2=[];
flag=0;


%% List of participants 

lista={meta{:,1}};
lista=cellfun(@num2str,lista,'un',0);
[indxa,tfa] = listdlg('ListString',lista);


%% List of inputs

list=meta{indxa,2}.una(:);
list=[list;'goal difficulty']
list=cellfun(@num2str,list,'un',0);
[indx,tg] = listdlg('ListString',list);
abc=[];
i=indxa
data1=meta{i,2}; %i th participant
data2=meta{i,5};
inp=data2.u;
[l b h]=size(data1);

% prompt=('Choose na: ');
% na=input(prompt);
% prompt=('Choose nb: ');
% nb=input(prompt);
% prompt=('Choose nk: ');
% nk=input(prompt);

prompt=('Choose arx structure: ');
order=input(prompt);

prompt=('Choose est/val matrix: ');
ev_matrix=input(prompt);

%% Input definitions


msg = "Choose output";
opts = ["Behavior" "Goal Attainment" "Goal Achievement"];
choice = menu(msg,opts);

if (choice==1)
    goal_achievement=data1.y(:,1);
elseif (choice==2)
    goal_achievement=data1.y(:,1)-data1.u(:,1);
else
    goal_achievement=data1.y(:,1)./data1.u(:,1);
end

baseline=min(data1.u(:,1));%minimum number of steps of the person across entire data range

%%

goal_achievement=goal_achievement-mean(goal_achievement);
%goal_achievement=detrend(goal_achievement);
study_day=1:l;
study_day=study_day';
%goal_difficulty=study_day;
goal_difficulty=data1.u(:,1)./baseline; %input 1
goal_difficulty=goal_difficulty-mean(goal_difficulty);

data1.u(:,1)=data1.u(:,1)-mean(data1.u(:,1));
data1.u(:,3)=data1.u(:,3)-mean(data1.u(:,3));
data1.u(:,2)=data1.u(:,2)-mean(data1.u(:,2));

%% Generating the input matrix

for i=1:length(indx)
    p=indx(i)
    if p==9
        abc=[abc goal_difficulty];
    else
        abc=[abc data1.u(:,p)];
    end
end

%%


 datajw=iddata(goal_achievement,abc,1);
 datajw.yna = 'Goal Achievement';

if indx(end)==9
    datajw.una(1:end-1)=data1.una(indx(1:end-1));
    datajw.una(end)={'Goal Difficulty'};
else
    datajw.una(1:end)=data1.una(indx(1:end));
end


inputChannels=datajw.una;
outputChannels=datajw.yna;
datajw=datajw(1:80);



%% Separating into experiments

l_exp=cell2mat(cellfun(@length,inp,'UniformOutput',false));
djw1=datajw(1:l_exp(1));
djw2=datajw(l_exp(1)+1:l_exp(1)+l_exp(2));
djw3=datajw(l_exp(1)+l_exp(2)+1:l_exp(1)+l_exp(2)+l_exp(3));
djw4=datajw(l_exp(1)+l_exp(2)+l_exp(3)+1:l_exp(1)+l_exp(2)+l_exp(3)+l_exp(4));
djw5=datajw(l_exp(1)+l_exp(2)+l_exp(3)+l_exp(4)+1:end);
datajw_m=merge(djw1,djw2,djw3,djw4,djw5);




%%

eset = find(ev_matrix == 1);
valset = find(ev_matrix == 0);

dataest = getexp(datajw_m,eset); 
dataval = getexp(datajw_m,valset);

model = arx(dataest,order);% model is the corresponding model
figure;compare(datajw,model)
for i=1:length(indxa)
    figure;step(model(:,i))
    
end