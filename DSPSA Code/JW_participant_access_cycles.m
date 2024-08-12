%close all;
%clear all;
%clc;
% Load Just Walk data for all participants
% load ('meta-Just_Walk.mat');

% Select Participant from list
part_list = {'Participant 08','Participant 57','Participant 73','Participant 115','Participant 123','Participant 149','Participant 156','Participant 164','Participant 172','Participant 180','Participant 198','Participant 206','Participant 214','Participant 222','Participant 230','Participant 248','Participant 255','Participant 263'};
[part_indx,part_tf] = listdlg('SelectionMode','single','ListString',part_list);

% Overall data for selected participant
overalldata = meta_cpy{part_indx,5}; % Cycles
overalldata2 = meta_cpy{part_indx,3}; % Mean subtracted all data

%inputchannels = ['Goals']; %placeholder to be replaced by interaction terms later (line 54)
%outputchannels = {'Behavior'};

% Overall participant data based on output and selected inputs
%overall = overalldata(:,outputchannels,inputchannels);

if interactonly == 1
        
    inputchannels = ['Goals']; %placeholder to be replaced by interaction terms later (line 54)
    outputchannels = {'Behavior'};

    % Overall participant data based on output and selected inputs
    overall = overalldata(:,outputchannels,inputchannels); 
    overall2 = overalldata2(:,outputchannels,inputchannels); 
    
     for i = 1:1:interact         
        input_str = ["Goals","Expected Points","Granted Points","PredBusy","PredStress","PredTypical","Wknd","Temperature"];
        [indx_int,tf_int] = listdlg('ListString',input_str,'SelectionMode','multiple','PromptString','Select Interactions (>=2):'); 
    
        if length(indx_int) < 2
        error('Only one term selected - select more than one term for interaction or set interact = 0 for no interaction terms.'); %if only one term is selected, no interaction term will be used 

        end
        
      interactinputs = inputs(indx_int);
      interactionterminputs(i,:) = inputs(indx_int); %to display interaction term inputs in ARX_JW_Plot
      
      interactdata = overalldata(:,outputchannels,interactinputs); %interaction terms individually listed
      interactdata2 = overalldata2(:,outputchannels,interactinputs);
    
      interactterm = prod(interactdata.u'); %multiply together values of the two terms interacting
      interaction(:,i) = interactterm'; %re-transform interaction term vector
      
      interactterm2 = prod(interactdata2.u');
      interaction2(:,i) = interactterm2';
      
     end 
     
    % Re-write "overall" - add input channels as interaction terms (ONLY)
    for i = 1:1:interact
        overall.u(:,i) = interaction(:,i);
        overall2.u(:,i) = interaction2(:,i);
    end
    
else %interactonly == 0; both interaction and single input terms used OR only single input terms used

    % Select Inputs from list
    input_str = ["Goals","Expected Points","Granted Points","PredBusy","PredStress","PredTypical","Wknd","Temperature"];
    [indx_inp,tf_inp] = listdlg('ListString',input_str,'SelectionMode','multiple','PromptString','Select Inputs:');

    % Define inputchannel based on selected inputs
    inputs = {'Goals','Expected Points','Granted Points','PredBusy','PredStress','PredTypical','Wknd','Temperature'};
    inputchannels = inputs(indx_inp);

    % Number of inputs
    num_inp = length(inputchannels);

    % Select inputs for interaction term 
    if interact >= 1
     % Define input and output channels
        inputchannels = inputs(indx_inp); %single input channels
        outputchannels = {'Behavior'};
        
     % Overall Data
        overall = overalldata(:,outputchannels,inputchannels);
        overall2 = overalldata2(:,outputchannels,inputchannels);
        
    % Interaction Terms 
          for i = 1:1:interact
          [indx_int,tf_int] = listdlg('ListString',input_str,'SelectionMode','multiple','PromptString','Select Interactions (>=2):'); 
    
                if length(indx_int) < 2
                error('Only one term selected - select more than one term for interaction or set interact = 0 for no interaction terms.'); %if only one term is selected, no interaction term will be used 

                end
        
            interactinputs = inputs(indx_int);      
            interactionterminputs(i,:) = inputs(indx_int); %to display interaction term inputs
      
            interactdata = overalldata(:,outputchannels,interactinputs); %interaction terms individually listed
            interactdata2 = overalldata2(:,outputchannels,interactinputs);
    
            interactterm = prod(interactdata.u'); %multiply together values of the two terms interacting
            interaction(:,i) = interactterm'; %re-transform interaction term vector
            
            interactterm2 = prod(interactdata2.u');
            interaction2(:,i) = interactterm2';
           
          end 
        
        % Re-write "overall"
        [a,b] = size(inputchannels); %Need number of rows to add interaction term to the end over "overall"
        for i = 1:1:interact
            overall.u(:,b+i) = interaction(:,i);
            overall2.u(:,b+i) = interaction2(:,i)
        end
        
    else %If no interaction terms - run as usual
    
     % Define input and output channels
        inputchannels = inputs(indx_inp); %single input channels
        outputchannels = {'Behavior'};

     % Overall data
        overalldata = meta_cpy{part_indx,5};
        overalldata2 = meta_cpy{part_indx,3}; % Not Cycles, Mean Subtracted
        overall = overalldata(:,outputchannels,inputchannels);
        overall2 = overalldata2(:,outputchannels,inputchannels);
    end
end

% Define length of estimation and validation data
%samples = length(overall.y);    % Length of overall data
%est_len = round((70/100)*samples,0);    % Length of estimation data

% Split participant data into estimation and validation datasets
%est_dat = overall(1:est_len);
%val_dat = overall(est_len+1:samples);

% Generate 30 logarithmically spaced values of gamma in the range of 10 to
% 10^7
%gamma = logspace(0,7,30);

% Initialize arrays which will later be used for generating plots
% Loss Function
%LossFn_o = [];
%LossFn_e = [];
%LossFn_v = [];

% MSE
%MSE_ovr = [];
%MSE_est = [];
%MSE_val = [];

% Fit Percent
%fit_ovr = [];
%fit_est = [];
%fit_val = [];

% Parameter 2-norm
%par_2n = [];

% FIR/ARX order based on # inputs
%na = 0;
%nb = 10*ones(1,num_inp);
%nk = zeros(1,num_inp);
%order = [na,nb,nk];

%for L = gamma
    % Ridge Reression (R = 1)
%    opt = arxOptions;
%    opt.Regularization.Lambda = L;
    %     opt.Regularization.R = R;
%    M = arx(est_dat,order,opt);     % ARX model
    
    % Compute MSE and Loss Function for ARX model wrt Overall data
%    err_o = pe(M,overall,1);    % One-step prediction error for identified model
%    sq_err_o = [];
%    for i = 1:length(err_o.y)
%        sq_err_o = [sq_err_o;err_o.y(i)^2]; % Squared error at each point
%    end
%    sum_err_o = sum(sq_err_o);      % Sum of squared errors
%    MSE_o = sum_err_o/length(err_o.y);      % MSE
%    MSE_ovr = [MSE_ovr;MSE_o];
%    V_o = MSE_o + (L*M.Report.Parameters.ParVector'*M.Report.Parameters.ParVector)/length(err_o.y);   % Loss Function
%    LossFn_o = [LossFn_o;V_o];
    
    % Compute MSE and Loss Function for ARX model wrt Estimation data
%    err_e = pe(M,est_dat,1);
%    sq_err_e = [];
%    for i = 1:length(err_e.y)
%        sq_err_e = [sq_err_e;err_e.y(i)^2];
%    end
%    sum_err_e = sum(sq_err_e);
%    MSE_e = sum_err_e/length(err_e.y);
%    MSE_est = [MSE_est;MSE_e];
%    V_e = MSE_e + (L*M.Report.Parameters.ParVector'*M.Report.Parameters.ParVector)/length(err_e.y);
%    LossFn_e = [LossFn_e;V_e];
       
    % Compute MSE and Loss Function for ARX model wrt Validation data
%    err_v = pe(M,val_dat,1);
%    sq_err_v = [];
%    for i = 1:length(err_v.y)
%        sq_err_v = [sq_err_v;err_v.y(i)^2];
%    end
%    sum_err_v = sum(sq_err_v);
%    MSE_v = sum_err_v/length(err_v.y);
%    MSE_val = [MSE_val;MSE_v];
%    V_v = MSE_v + (L*M.Report.Parameters.ParVector'*M.Report.Parameters.ParVector)/length(err_v.y);
%    LossFn_v = [LossFn_v;V_v];
        
    % Compute parameter 2-norm for ARX model
%    parnorm_2 = norm(M.Report.Parameters.ParVector,2);
%    par_2n = [par_2n;parnorm_2];
    
    % Compute fits for the ARX model
    % Overall data
%    [~,fit_o,~] = compare(overall,M);
%    fit_ovr = [fit_ovr;fit_o];
%    % Esimation data
%    [~,fit_e,~] = compare(est_dat,M);
%    fit_est = [fit_est;fit_e];
%    % Validation data
%   [~,fit_v,~] = compare(val_dat,M);
%    fit_val = [fit_val;fit_v];
%end


% Plot of log of gamma vs Loss function (overall)
%subplot(3,2,1)
%plot(log10(gamma),LossFn_o)
%xlabel('log(gamma)')
%ylabel('Loss Func')
%title('Loss Func (overall)')

% Plot of log of gamma vs MSE (overall)
%subplot(3,2,2)
%plot(log10(gamma),MSE_ovr)
%xlabel('log(gamma)')
%ylabel('MSE')
%title('MSE (overall)')

% Plot of log of gamma vs Loss function (estimation)
%subplot(3,2,3)
%plot(log10(gamma),LossFn_e)
%xlabel('log(gamma)')
%ylabel('Loss Func')
%title('Loss Func (est)')

% Plot of log of gamma vs MSE (estimation)
%subplot(3,2,4)
%plot(log10(gamma),MSE_est)
%xlabel('log(gamma)')
%ylabel('MSE')
%title('MSE (est)')

% Plot of log of gamma vs Loss function (validation)
%subplot(3,2,5)
%plot(log10(gamma),LossFn_v)
%xlabel('log(gamma)')
%ylabel('Loss Func')
%title('Loss Func (val)')

% Plot of log of gamma vs MSE (validation)
%subplot(3,2,6)
%plot(log10(gamma),MSE_val)
%xlabel('log(gamma)')
%ylabel('MSE')
%title('MSE (val)')

%suptitle([cell2mat(part_list(part_indx)),': Inputs ',mat2str(input_str(indx_inp))])

%figure

% Plot of log of gamma vs parameter 2-norm
%subplot(2,1,1)
%plot(log10(gamma),par_2n)
%xlabel('log(gamma)')
%ylabel('Par 2-norm')
%title('Lambda vs. Parameter 2-norm')

% Plot of log of gamma vs log of parameter 2-norm
%subplot(2,1,2)
%plot(log10(gamma),log(par_2n))
%xlabel('log(gamma)')
%ylabel('log(Par 2-norm)')

%suptitle([cell2mat(part_list(part_indx)),': Inputs ',mat2str(input_str(indx_inp))])

%figure

% Plot of log of gamma vs percent fit (overall)
%subplot(3,1,1)
%plot(log10(gamma),fit_ovr)
%xlabel('log(gamma)')
%ylabel('Fit Percent')
%title('Lambda vs. Fit Percent (overall)')

% Plot of log of gamma vs percent fit (estimation)
%subplot(3,1,2)
%plot(log10(gamma),fit_est)
%xlabel('log(gamma)')
%ylabel('Fit Percent')
%title('Lambda vs. Fit Percent (est)')

% Plot of log of gamma vs percent fit (validation)
%subplot(3,1,3)
%plot(log10(gamma),fit_val)
%xlabel('log(gamma)')
%ylabel('Fit Percent')
%title('Lambda vs. Fit Percent (val)')

%suptitle([cell2mat(part_list(part_indx)),': Inputs ',mat2str(input_str(indx_inp))])