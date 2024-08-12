load meta.mat
df = meta{10,5};
df = df(:,:,[1 2 3 4 5 6 7 8]);
dumy = mean(meta{15,2}.u);
umeans = dumy([1 2 3 4 5 6 7 8]);
ymeans=mean(meta{15,2}.y)
inputnames = df.una;
% inputnames{4} = 'Weekend';
outputnames = df.yna;
nu=8;
NumberOfPlotRows = nu+2;
tplot = df.SamplingInstants;
for i = 1:nu+1
        for ii = 1:length(tplot)
            if i <= nu
                subplot(NumberOfPlotRows,1,i)
                if ii ~= length(tplot)
                    tplott = [tplot{ii}(1:end); tplot{ii+1}(1)];
                    yplott = [df.u{ii}(:,i)+umeans(i); df.u{ii+1}(1,i)+umeans(i)];
                else
                    tplott = tplot{ii}(1:end);
                    yplott = df.u{ii}(:,i)+umeans(i);
                end
                stairs(tplott,yplott,LineWidth=1.5)
                xlim([tplot{1}(1) tplot{end}(end)])
                title("\bf"+inputnames{i},"FontSize",14)
                hold on;
            else
                if ii ~= length(tplot)
                    tplott = [tplot{ii}(1:end); tplot{ii+1}(1)];
                    yplott = [df.y{ii}+ymeans; df.y{ii+1}(1)+ymeans];
                else
                    tplott = tplot{ii}(1:end);
                    yplott = df.y{ii}+ymeans;
                end
                subplot(NumberOfPlotRows,1,[i,i+1])
%                 p_actual = plot(sequ{ii}(1:end-1),dfdata.y{ii}+ymeans{ii},'k');hold on;
%                 p_predicted = plot(sequ{ii}(1:end-1),yarx.y{ii}+ymeans{ii},"--r");
%                 p_predicted = stairs(tplot{ii}(1:end),y_sim{ii}.y+ymeans{ii},"--r",LineWidth=1.25); hold on
                p_actual = stairs(tplott,yplott,LineWidth=1.25);hold on;
%                 p_predicted = stairs(sequ{ii}(1:end-1),yarx.y{ii}+ymeans{ii},"--r");
                title("\bf"+outputnames,"FontSize",14)
                xlim([tplot{1}(1) tplot{end}(end)])
                hold on;
            end
        end
%         if i > nu
% 
% %             subplot(NumberOfPlotRows,1,[i,i+1])
% %             yfill = [max(cell2mat(df.y'))+max(cell2mat(ymeans)) max(cell2mat(df.y'))+max(cell2mat(ymeans)) min(cell2mat(df.y'))+min(cell2mat(ymeans)) min(cell2mat(df.y'))+min(cell2mat(ymeans))];
% %             hold on;
% %             for j = 1:length(val_exp)
% %                 p_val = fill([tplot{val_exp(j)}(1) tplot{val_exp(j)}(end) tplot{val_exp(j)}(end) tplot{val_exp(j)}(1)],yfill,lightblue,'LineStyle','none','FaceAlpha',0.3);
% %             end
% %             xlim([tplot{1}(1) tplot{end}(end)]);
% %             ylim([min(cell2mat(df.y'))+min(cell2mat(ymeans)) max(cell2mat(df.y'))+max(cell2mat(ymeans))])
% %             for j = 1:length(est_exp)
% %                 p_est = fill([tplot{est_exp(j)}(1) tplot{est_exp(j)}(end) tplot{est_exp(j)}(end) tplot{est_exp(j)}(1)],yfill,grey,'LineStyle','none','FaceAlpha',0.3);
% %             end
% %             
% %             
% %             mm = legend([p_actual p_predicted p_val p_est], {"Actual " + outputnames,fitarxst,ValidationFit, EstimationFit});
% %             set(mm,'FontSize',14);
% %             xlabel('Time (days)')
% %             set(gca,'children',flipud(get(gca,'children')))
% %             hold off;
%         end
end
xlabel('Time (days)')

%% JUST WALK JITAI
clear all;

d = readtable("preprocessed.csv");
% datarange = (184:311);%(1:118);(924:1043);(924:1043); %
part_list = unique(d.rnum);
part_num =5;
selected_par = d(d.rnum==part_num,:);

steps = selected_par.steps;
n_cycles = floor(length(steps)/26);
cycle_len = 26;
steps = steps(1:n_cycles*cycle_len);
avg = mean(reshape(steps,cycle_len,[]));
goals = selected_par.stepgoal(1:n_cycles*cycle_len);
day = selected_par.day_index(1:n_cycles*cycle_len);
% steps = d.steps(datarange)
% goals = d.stepgoal(datarange);%(1:118);
% day = d.day_index(datarange);%(1:118);
goal_attainment = steps-goals;
length(goal_attainment(goal_attainment>=0))/length(goal_attainment)
figure;
subplot(311)
stairs(1:length(steps),steps,LineWidth=1.5);hold on
% stairs(1:cycle_len:length(steps),avg)
xlim([1 length(steps)]); title("Daily Stepcount")
subplot(312)
stairs(1:length(goals),goals,LineWidth=1.5);hold on
% stairs(cycle_len:cycle_len:length(steps),avg)
xlim([1 length(steps)]); title("Daily Goals")
subplot(313)
stairs(1:length(goals),goal_attainment,LineWidth=1.5);hold on
xlim([1 length(steps)]); title("Goal Attainment")
xlabel("Time (days)")

%% 
clear all 
d = readtable("levels.csv");
d2 = readtable("bout_noti2.csv");
dateandtime = d2.created;
for i = 1:length(dateandtime)
    Xplot(i) = datetime(dateandtime{i},'InputFormat','yyyy-MM-dd HH:mm:ssZ','TimeZone','America/New_York');
end

xplot = Xplot(d2.rnum == 1);
%%
Yplot = string(d2.answered(d2.rnum == 1));
yplot =[];
yplot(Yplot=="True") = 2;
yplot(Yplot=="False") = 1;
figure;scatter(datenum(xplot),yplot)
xticks=get(gca,'Xtick')
xtickangle(45)
set(gca,'xticklabel',datestr(xticks,'dd/mm/yyyy'))


