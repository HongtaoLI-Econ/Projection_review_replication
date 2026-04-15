clear variables
close all

% 1. set home
home = '';
cd(home)

figure_save = 1;   
data_save   = 1;   

%font size
fs   = 25;       
fn   = 'YuGothic';
ldfs = 25;       
figure_save = 1;
%projectionname = ["Fujii-Nakata","3-2","3-3","Hirata","CATs"];
projectionname = ["AB 3-3","AB 3-2","Fujii-Nakata","Hirata","CATs"];

n = numel(projectionname);

%The "big" table
%BTT(1:n) = struct('projectionname',[],'TT',[]);
BTT(1:n) = struct('projectionname',[],'TT',[], ...
    'rmse_all',[], 'rmse_rising',[], 'rmse_peak',[]...
    , 'rmse_falling',[], 'rmse_wave',[]...
    ,'rmsep_all',[], 'rmsep_rising',[], 'rmsep_peak',[]...
    , 'rmsep_falling',[], 'rmsep_wave',[]...
    ,'bias_all',[], 'bias_rising',[], 'bias_peak',[]...
    , 'bias_falling',[], 'bias_wave',[] ...
    , 'biasp_all',[], 'biasp_rising',[], 'biasp_peak',[]...
    , 'biasp_falling',[], 'biasp_wave',[] ...
    , 'all_num',[], 'wave_num',[],'phase_num',[]);

%projectionnames = ["Fujii-Nakata","AB 3-2","3-3","Hirata","CATs"]
projectionnames = ["AB 3-3","AB 3-2","Fujii-Nakata","Hirata","CATs"];



for j = 1:n
    BTT(j).projectionname = projectionnames(j);
end
%% 

for j = 1:numel(projectionname)

    if projectionname(j) == "AB 3-3"
   %load CSV
    filename      = 'data/3_3.csv';
    delimiterIn   = ',';
    headerlinesIn = 1;
    Ncsv = importdata(filename, delimiterIn, headerlinesIn);
    Ndata = Ncsv.data(:, 1:end);
    %date format “yyyy/MM/dd”
    date = string(Ncsv.textdata(2:end,1));
    %nishiura
    ind    = find(date == "2021/3/20",  1); 
    ending = find(date == "2023/5/7",   1);
    %Nishiura
    troughs = [ ...
        datetime('2021-03-14','InputFormat','yyyy-MM-dd'), ...
        datetime('2021-06-13','InputFormat','yyyy-MM-dd'), ...
        datetime('2021-11-21','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-06-14','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-10-10','InputFormat','yyyy-MM-dd'), ...
        datetime('2023-03-21','InputFormat','yyyy-MM-dd') ];
    peaks = [ ...
        datetime('2021-05-07','InputFormat','yyyy-MM-dd'), ...
        datetime('2021-08-17','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-02-07','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-07-27','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-12-26','InputFormat','yyyy-MM-dd') ];

    %Nishiura
    interval = 90; 
    wave_initial = 4; 

    %Length for spaghetti chart
    nperiods = 22;
    %Prediction length
    pre_length = 42;
 
   %% 3-2
    elseif  projectionname(j) == "AB 3-2"
   %load CSV
    filename      = 'data/3_2.csv';
    delimiterIn   = ',';
    headerlinesIn = 1;
    Ncsv = importdata(filename, delimiterIn, headerlinesIn);
    Ndata = Ncsv.data(:, 1:end);

    %date format “yyyy/MM/dd”
    date = string(Ncsv.textdata(2:end,1));
    %Suzuki
    ind    = find(date == "2022/1/10",  1);
    ending = find(date == "2023/5/4",   1);
    %Suzuki
    troughs = [ ...
        datetime('2022-01-10','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-06-14','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-10-10','InputFormat','yyyy-MM-dd'), ...
        datetime('2023-03-21','InputFormat','yyyy-MM-dd') ];
    peaks = [ ...
        datetime('2022-02-07','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-07-27','InputFormat','yyyy-MM-dd'), ...
        datetime('2022-12-26','InputFormat','yyyy-MM-dd') ];

    interval = 90; %Suzuki
    wave_initial = 6; %Suzuki

    %Length for spaghetti chart
    nperiods = 1;
    %Prediction length
    pre_length = 1;
%% 

    elseif  projectionname(j) == "Fujii-Nakata"
    %load CSV
    filename      = 'data/FN.csv';
    delimiterIn   = ',';
    headerlinesIn = 1;
    Ncsv = importdata(filename, delimiterIn, headerlinesIn);
    Ndata = Ncsv.data(:, 1:end);

    %date format “yyyy/MM/dd”
    date = string(Ncsv.textdata(2:end,1));


    %set start and end
ind    = find(date == "2021/1/13",  1);
ending = find(date == "2023/5/3",   1);

% Define troughs and peaks
troughs = [ ...
    datetime('2021-03-03','InputFormat','yyyy-MM-dd'), ...
    datetime('2021-06-9','InputFormat','yyyy-MM-dd'), ...
    datetime('2021-11-24','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-06-15','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-10-12','InputFormat','yyyy-MM-dd'), ...
    datetime('2023-03-22','InputFormat','yyyy-MM-dd') ];
peaks = [ ...
    datetime('2021-04-28','InputFormat','yyyy-MM-dd'), ...
    datetime('2021-08-18','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-02-09','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-08-03','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-12-28','InputFormat','yyyy-MM-dd') ];

    interval = 12; %FN
    wave_initial = 4; %FN

    %Length for spaghetti chart
    nperiods = 4;
    %Prediction length
    pre_length = 4;
    %% 

    elseif projectionname(j) == "Hirata"

    %load CSV
    filename      = 'data/Hirata.csv';
    delimiterIn   = ',';
    headerlinesIn = 1;
    Ncsv = importdata(filename, delimiterIn, headerlinesIn);
    Ndata = Ncsv.data(:, 1:end);

    %date format “yyyy/MM/dd”
    date = string(Ncsv.textdata(2:end,1));

        %set start and end
    ind    = find(date == "2021/5/1",  1);
    ending = find(date == "2023/5/3",   1);
   
    % Define troughs and peaks
    troughs = [ ...
    datetime('2021-08-5','InputFormat','yyyy-MM-dd'), ...
    datetime('2021-11-28','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-06-16','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-10-11','InputFormat','yyyy-MM-dd'), ...
    datetime('2023-03-22','InputFormat','yyyy-MM-dd')];
    peaks = [ ...
    datetime('2021-08-19','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-02-08','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-08-03','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-12-27','InputFormat','yyyy-MM-dd') ];

    interval = 90; %Hirata
    wave_initial = 5; %Hirata
    
    %Length for spaghetti chart
    nperiods = 28;
    %Prediction length
    pre_length = 42;
%% 

    elseif  projectionname(j) == "CATs"

    %load CSV
   
    filename      = 'data/CATs.csv';
    delimiterIn   = ',';
    headerlinesIn = 1;
    Ncsv = importdata(filename, delimiterIn, headerlinesIn);
    Ndata = Ncsv.data(:, 1:end);

    %date format “yyyy/MM/dd”
    date = string(Ncsv.textdata(2:end,1));

        %set start and end
    ind    = find(date == "2022/1/5",  1);
    ending = find(date == "2023/5/3",   1);
   
    % Define troughs and peaks
    troughs = [ ...
    datetime('2021-11-28','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-06-16','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-10-11','InputFormat','yyyy-MM-dd'), ...
    datetime('2023-03-22','InputFormat','yyyy-MM-dd')];
    peaks = [ ...
    datetime('2022-02-08','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-08-03','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-12-27','InputFormat','yyyy-MM-dd') ];

    interval = 90; %CATs
    wave_initial = 6; %CATs
    
    %Length for spaghetti chart
    nperiods = 28;
    %Prediction length
    pre_length = 42;

    end




%load data and obtain duration
Ndata  = Ndata(ind:ending, :);
date   = date(ind:ending);
duration = numel(date);



% Number of Projections 
nWide   = size(Ndata,2);  
lastind = find(~isnan(Ndata(:,1)), 1, 'last') +1 ;



%Fomalize the date format
date_dt = datetime(date, 'InputFormat', 'yyyy/MM/dd');
%New panel contains actuals ahead and prediction
Npanel = NaN(duration,20);
Npanel(:,1) = date;
Npanel(:,2) = Ndata(:,1);

%load actual data from the raw file
actual = Ndata(:,1);



% Genrate empty the Projection and act paths with pre_length
pre_path = NaN(duration,pre_length);
act_path = NaN(duration,pre_length);
act_path(:,1) = actual; 

% %Spaghetti chart for all samples
for iW = nperiods
    figure('Color','w','Position',[100 100 1200 800])
    plot(Ndata(:, 1), 'k-', 'LineWidth', 2.0)
    hold on

    Nmax = 0;
    
    iWide = 2;
    while iWide <= nWide 
% Find the starting date of each Projection column
    x = find(~isnan(Ndata(:,iWide)), 1);
% Plot Projection path setting NaNs before the initial Projection date
      if projectionname(j) == "AB 3-2"
         plot([nan(x-1,1); Ndata(x, iWide)], 'r.','LineWidth',1.0,'MarkerSize',20);
      else
        if x+iW-1 >= duration
        plot([nan(x-1,1); Ndata(x:duration, iWide)], 'r-','LineWidth',1.0);
        else
        plot([nan(x-1,1); Ndata(x:x+iW-1, iWide)], 'r-','LineWidth',1.0);
        end
      end
    % Collet the maximum
    if x + iW - 1 > duration
        if max(Ndata(x:duration, iWide)) > Nmax
        Nmax = max(Ndata(x:duration, iWide)); 
        end
    else
        if max(Ndata(x:x+iW-1, iWide)) > Nmax
        Nmax = max(Ndata(x:x+iW-1, iWide));
        end
    end
    % Next column
    % Record the Projection path
    % Transpose a Projection column starting at date x to a row
    if x+pre_length-1 <= duration
        pre_path(x,:) = transpose(Ndata(x:x+pre_length-1, iWide));
    else
        pre_path(x,1:(length(Ndata(x:end, iWide)))) = transpose(Ndata(x:end, iWide));
     end
 

    % Record the actual path
    % Transpose a actual column starting at date x to a row
                if x+pre_length-1 < duration
             act_path(x,1:pre_length) = transpose(Ndata(x:x+pre_length-1, 1)); 
                else
             act_path(x,1:(length(Ndata(x:end, 1)))) = transpose(Ndata(x:end, 1));       
                end
            iWide = iWide + 1;
         end

%     xtickR = duration;
%     xticks(1:interval:xtickR)
% xticklabels(string(datetime(xticks, 'ConvertFrom', 'datenum'), 'yyyy/MM'));
%     xtickangle(45)

xtick_indices = 1:interval:duration; 
    xtick_indices = xtick_indices(xtick_indices <= length(date_dt));
    
    xticks(xtick_indices);
    
   
    target_dates = date_dt(xtick_indices); 
    yy = year(target_dates);              
    mm = month(target_dates);             

    labels = compose("%d/%02d", yy, mm);   
    
    xticklabels(labels); 
    
    
    xtickangle(45);       
    xlim([1 duration]);   
    
    
    ymax = 1.1 * Nmax;
    ylim([0 ymax]);
    
    if projectionname(j) == "AB 3-3"
       ylim([0 0.3*Nmax])
    else 
       ylim([0 1.05*Nmax]) 
    end
    ax = gca;
    ax.YAxis.FontSize = ldfs;
    ax.XAxis.FontSize = ldfs;
    ax.YAxis.Exponent = 0;

    % legend handles (added without changing existing plot commands)
    hActual = plot(nan, nan, 'k-', 'LineWidth', 2.0);
    if projectionname(j) == "AB 3-2"
        hProj = plot(nan, nan, 'r.', 'LineWidth', 1.0, 'MarkerSize', 20);
    else
        hProj = plot(nan, nan, 'r-', 'LineWidth', 1.0);
    end
    lgd = legend([hActual, hProj], {'Actual', 'Projection'}, ...
        'Location', 'northeast', 'FontSize', 20, 'Box', 'on');
    lgd.ItemTokenSize = [30, 18];

    figname1 = ' New Cases';
    figname2 = [sprintf('%.0f', iW), ' days'];
    title([convertStringsToChars(projectionname(j)),figname1, ', ', figname2], 'FontSize', fs, 'FontWeight', 'normal', 'FontName', fn)

    hold off;


 end

%Generate phase vector
phase = NaN(duration,1);

%Generate wave vector
wave = NaN(duration,1);

%Generate errors for each Projection horizon
error = NaN(duration,pre_length);
error = pre_path - act_path;
errorp = error./act_path;

%Generate square errors for each Projection horizon
error_square = NaN(duration,pre_length);
error_square = error.^2;
errorp_square = NaN(duration,pre_length);
errorp_square = errorp.^2;

% Setting phase

phase = repmat("other", size(date_dt));

%% 

% Window of peak
windays = 7;

%Mark phase and wave
for i = 1:numel(peaks)
    % Mark peak phase 
    peak_current = peaks(i);
    idx_peak = (date_dt >= peak_current-days(windays)) & (date_dt <= peak_current+days(windays));
    phase(idx_peak) = "peak";
    % Mark rising phase
    trough_current = troughs(i);
    idx_rise = (date_dt >= trough_current) & (date_dt < peak_current - days(windays));
    phase(idx_rise) = "rising";
    % Mark falling phase
    trough_next = troughs(i+1);
    idx_fall = (date_dt > peak_current + days(windays)) & (date_dt <= trough_next);
    phase(idx_fall) = "falling";
    % Mark wave
    idx_wave = (date_dt >= trough_current) & (date_dt <= trough_next);
    %wave(idx_wave) = i+3; nakata
    wave(idx_wave) = i+wave_initial-1; %SUZUKI
end

%Spaghetti chart for 3 phases
fig_phase = figure('Color','w','Position',[100 100 1200 800]);
hold on;
for iW = nperiods
    set(gcf, 'Position', [100, 100, 1200, 800])
    plot(Ndata(:, 1), 'k-', 'LineWidth', 2.0)
    hold on

    Nmax = 0;
    
    iWide = 2;
    while iWide <= nWide 
% Find the starting date of each Projection column
    x = find(~isnan(Ndata(:,iWide)), 1);
% Plot Projection path setting NaNs before the initial Projection date
        if projectionname(j) == "AB 3-2"
         plot([nan(x-1,1); Ndata(x, iWide)], 'r.','LineWidth',1.0,'MarkerSize',20);
        else
        if x+iW-1 >= duration
        plot([nan(x-1,1); Ndata(x:duration, iWide)], 'r-','LineWidth',1.0);
        else
        plot([nan(x-1,1); Ndata(x:x+iW-1, iWide)], 'r-','LineWidth',1.0);
        end
      end
% Collet the maximum
    if x + iW - 1 > duration
        if max(Ndata(x:duration, iWide)) > Nmax
        Nmax = max(Ndata(x:duration, iWide)); 
        end
    else
        if max(Ndata(x:x+iW-1, iWide)) > Nmax
        Nmax = max(Ndata(x:x+iW-1, iWide));
        end
    end
 % Next column
 % Record the Projection path
 % Transpose a Projection column starting at date x to a row
if x+pre_length-1 <= duration
     pre_path(x,:) = transpose(Ndata(x:x+pre_length-1, iWide));
 else
     pre_path(x,1:(length(Ndata(x:end, iWide)))) = transpose(Ndata(x:end, iWide));
end
 % Record the actual path
 % Transpose a actual column starting at date x to a row
            if x+pre_length-1 < duration
        act_path(x,1:pre_length) = transpose(Ndata(x:x+pre_length-1, 1)); 
            end

        iWide = iWide + 1;
    end

ymax_all = 1.1 * max(max(Ndata));

    for k = 1:numel(peaks)
    % (A) peak 
    p = peaks(k);
    %idx_start =  p - days(windays);
    %idx_end   =  p + days(windays);
     %idx_start = find(datetime(date) == p - days(windays), 1);
     %idx_end   = find(datetime(date) == p + days(windays), 1);
     idx_start = find(date_dt == p - days(windays), 1);
     idx_end   = find(date_dt == p + days(windays), 1);
    if ~isempty(idx_start) && ~isempty(idx_end)
        x_patch = [idx_start, idx_end, idx_end, idx_start];
        y_patch = [0, 0, ymax_all, ymax_all];
        patch(x_patch, y_patch, [0.6 0.6 0.6], ...
              'EdgeColor','none', 'FaceAlpha',0.3);
    end
    % (B) falling: from the end of peak to next troughs(k+1)
    if k < numel(troughs)
        idx_fall_start = idx_end;  
        idx_fall_end   = find(date_dt == troughs(k+1), 1);
        if ~isempty(idx_fall_start) && ~isempty(idx_fall_end) && idx_fall_end >= idx_fall_start
            x_patch_f = [idx_fall_start, idx_fall_end, idx_fall_end, idx_fall_start];
            y_patch_f = [0, 0, ymax_all, ymax_all];
            patch(x_patch_f, y_patch_f, [0.8 0.8 0.8], ...
                  'EdgeColor','none', 'FaceAlpha',0.3);
        end
    end
   
end

 
    xtick_indices = 1:interval:duration; 
    xtick_indices = xtick_indices(xtick_indices <= length(date_dt));
    xticks(xtick_indices);
    
  
    target_dates = date_dt(xtick_indices);
    labels = string(target_dates, 'yyyy-MMM');
    
    xticklabels(labels);
    
   
    xtickangle(45);       
    xlim([1 duration]);   
  
    ymax = 1.1 * Nmax;
    ylim([0 ymax]);
    
    if projectionname(j) == "AB 3-3"
       ylim([0 0.3*Nmax])
    else 
       ylim([0 1.05*Nmax]) 
    end
    
    
    ax = gca;
    ax.YAxis.FontSize = ldfs;
    ax.XAxis.FontSize = ldfs;
    ax.YAxis.Exponent = 0;

    % legend handles (added without changing existing plot commands)
    hActual = plot(nan, nan, 'k-', 'LineWidth', 2.0);
    if projectionname(j) == "AB 3-2"
        hProj = plot(nan, nan, 'r.', 'LineWidth', 1.0, 'MarkerSize', 20);
    else
        hProj = plot(nan, nan, 'r-', 'LineWidth', 1.0);
    end
    lgd = legend([hActual, hProj], {'Actual', 'Projection'}, ...
        'Location', 'northeast', 'FontSize', 20, 'Box', 'on');
    lgd.ItemTokenSize = [30, 18];

    figname1 = ' New Cases';
    if projectionname(j) == "Fujii-Nakata"
    figname2 = [sprintf('%.0f', iW), ' weeks'];    
    elseif    projectionname(j) == "AB 3-2"
    figname2 = [sprintf('%.0f', iW), ' week'];   
    elseif    projectionname(j) == "AB 3-3"
    figname2 = [sprintf('%.0f', (iW+6)/7), ' weeks']; 
    else
    figname2 = [sprintf('%.0f', iW/7), ' weeks'];
    end
    title([convertStringsToChars(projectionname(j)),figname1, ', ', figname2], 'FontSize', fs, 'FontWeight', 'normal', 'FontName', fn)
    
    
    if figure_save == 1

        save_dir = fullfile(home, 'figures');
        if ~exist(save_dir, 'dir')
            mkdir(save_dir);
        end

        file_name = strcat(projectionname(j), '_spaghetti_peakpm7.png');
        full_path = fullfile(save_dir, file_name);
        

        fprintf('Figure saved: %s\n', full_path);
    end

end




TT = timetable(date_dt, actual, act_path, pre_path, phase, wave, error, error_square, errorp, errorp_square);

all_num = NaN(1,pre_length);

        for k = 1:pre_length
    all_num(k) = sum((~isnan(TT.error(:,k))));
        end


%rmse
rmse_all = sqrt (mean (error_square,'omitnan'));
%rmsep
rmsep_all = sqrt (mean (errorp_square,'omitnan'));
%bias
bias_all = mean (error,'omitnan');
%biasp
biasp_all = mean (errorp,'omitnan');

%sample mean biasp
sm_biasp_all = biasp_all;
%Standard deviation of samples of biasp
sd_biasp_all = sqrt( mean((errorp - biasp_all).^2,'omitnan'))
%Standard deviation of sample mean biasp
number_SEM = zeros(1,length(sd_biasp_all));
for c = 1:length(sd_biasp_all)
number_SEM(c) = sum(~isnan(errorp(:,c)))
end 


sd_biasp_all = sd_biasp_all .* sqrt(number_SEM ./ max(number_SEM-1,1));

SEM_biasp_all = sd_biasp_all./sqrt(number_SEM);

SEM_biasp_all(number_SEM<=1) = NaN;
[ci_biasp_lower_all_90, ci_biasp_upper_all_90, ...
 ci_biasp_lower_all,    ci_biasp_upper_all, ...
 ci_biasp_lower_all_99, ci_biasp_upper_all_99, ...
 sig_biasp_all] = make_ci_and_sig(sm_biasp_all, SEM_biasp_all, number_SEM-1);

ci_biasp_all = [ci_biasp_lower_all; ci_biasp_upper_all];


%sample mean bias
sm_bias_all = bias_all;
%Standard deviation of samples of bias
sd_bias_all = sqrt(mean((error - bias_all).^2,'omitnan'));
%Standard deviation of sample mean bias
number_SEM = zeros(1,length(sd_bias_all));
for c = 1:length(sd_bias_all)
number_SEM(c) = sum(~isnan(error(:,c)));
end 
SEM_bias_all = sd_bias_all./sqrt(number_SEM);
ci_bias_lower_all = zeros(1,length(sd_bias_all));
ci_bias_lower_all = sm_bias_all - 1.96 * SEM_bias_all;

ci_bias_upper_all = zeros(1,length(sd_bias_all));
ci_bias_upper_all = sm_bias_all + 1.96 * SEM_bias_all;

ci_bias_all = [ci_bias_lower_all;ci_bias_upper_all];







% Wave specific timetable
TT_waves = cell(1,8);
for i = 1:8
    TT_waves{i} = TT([], :);
    %TT_waves{i} = TT(TT.wave == i+3, :); %fn
    TT_waves{i} = TT(TT.wave == i+wave_initial-1, :); %suzuki
end



% Phase specific timetable
TT_phase = cell(1,3);
for i = 1:3
    TT_phase{i} = TT([], :);
end

TT_phase{1} = TT(TT.phase == 'rising', :);
TT_phase{2} = TT(TT.phase == 'peak', :);
TT_phase{3} = TT(TT.phase == 'falling', :);

%Count number of samples by phase
phase_num = NaN(3,pre_length);

    for i = 1:3
        for k = 1:pre_length
    phase_num(i,k) = sum((~isnan(TT_phase{i}.error(:,k))));
        end
    end

% Phase specific error metrics

%rising

rmse_rising = sqrt (mean (TT_phase{1}.error_square,'omitnan'));
rmsep_rising = sqrt (mean (TT_phase{1}.errorp_square,'omitnan'));
bias_rising = mean (TT_phase{1}.error,'omitnan');
biasp_rising = mean (TT_phase{1}.errorp,'omitnan');
sd_bias_rising = sqrt(mean((TT_phase{1}.error - bias_rising).^2,'omitnan'));
sd_biasp_rising = sqrt(mean((TT_phase{1}.errorp - biasp_rising).^2,'omitnan'));

number_SEM_rising = zeros(1,length(sd_bias_rising));

  for c = 1:length(sd_bias_rising)
  number_SEM_rising(c) = sum(~isnan(TT_phase{1}.errorp(:,c)));
  end 

SEM_bias_rising = sd_bias_rising./sqrt(number_SEM_rising);

ci_bias_lower_rising = bias_rising - 1.96 * SEM_bias_rising;

ci_bias_upper_rising = bias_rising + 1.96 * SEM_bias_rising;


sd_biasp_rising = sd_biasp_rising .* sqrt(number_SEM_rising ./ max(number_SEM_rising-1,1));

SEM_biasp_rising = sd_biasp_rising./sqrt(number_SEM_rising);

SEM_biasp_rising(number_SEM_rising<=1) = NaN;
[ci_biasp_lower_rising_90, ci_biasp_upper_rising_90, ...
 ci_biasp_lower_rising,    ci_biasp_upper_rising, ...
 ci_biasp_lower_rising_99, ci_biasp_upper_rising_99, ...
 sig_biasp_rising] = make_ci_and_sig(biasp_rising, SEM_biasp_rising, number_SEM_rising-1);

% peak

rmse_peak = sqrt (mean (TT_phase{2}.error_square,'omitnan'));
rmsep_peak = sqrt (mean (TT_phase{2}.errorp_square,'omitnan'));
bias_peak = mean (TT_phase{2}.error,'omitnan');
biasp_peak = mean (TT_phase{2}.errorp,'omitnan');
sd_bias_peak = sqrt(mean((TT_phase{2}.error - bias_peak).^2,'omitnan'));
sd_biasp_peak = sqrt(mean((TT_phase{2}.errorp - biasp_peak).^2,'omitnan'));

number_SEM_peak = zeros(1,length(sd_bias_peak));

  for c = 1:length(sd_bias_peak)
  number_SEM_peak(c) = sum(~isnan(TT_phase{2}.errorp(:,c)));
  end 

SEM_bias_peak = sd_bias_peak./sqrt(number_SEM_peak);

ci_bias_lower_peak = bias_peak - 1.96 * SEM_bias_peak;

ci_bias_upper_peak = bias_peak + 1.96 * SEM_bias_peak;


sd_biasp_peak = sd_biasp_peak .* sqrt(number_SEM_peak ./ max(number_SEM_peak-1,1));

SEM_biasp_peak = sd_biasp_peak./sqrt(number_SEM_peak);

SEM_biasp_peak(number_SEM_peak<=1) = NaN;
[ci_biasp_lower_peak_90, ci_biasp_upper_peak_90, ...
 ci_biasp_lower_peak,    ci_biasp_upper_peak, ...
 ci_biasp_lower_peak_99, ci_biasp_upper_peak_99, ...
 sig_biasp_peak] = make_ci_and_sig(biasp_peak, SEM_biasp_peak, number_SEM_peak-1);

% falling

rmse_falling = sqrt (mean (TT_phase{3}.error_square,'omitnan'));
rmsep_falling = sqrt (mean (TT_phase{3}.errorp_square,'omitnan'));
bias_falling = mean (TT_phase{3}.error,'omitnan');
biasp_falling = mean (TT_phase{3}.errorp,'omitnan');

sd_bias_falling = sqrt(mean((TT_phase{3}.error - bias_falling).^2,'omitnan'));
sd_biasp_falling = sqrt(mean((TT_phase{3}.errorp - biasp_falling).^2,'omitnan'));

number_SEM_falling = zeros(1,length(sd_bias_falling));

  for c = 1:length(sd_bias_falling)
  number_SEM_falling(c) = sum(~isnan(TT_phase{3}.errorp(:,c)));
  end 

SEM_bias_falling = sd_bias_falling./sqrt(number_SEM_falling);

ci_bias_lower_falling = bias_falling - 1.96 * SEM_bias_falling;

ci_bias_upper_falling = bias_falling + 1.96 * SEM_bias_falling;



sd_biasp_falling = sd_biasp_falling .* sqrt(number_SEM_falling ./ max(number_SEM_falling-1,1));

SEM_biasp_falling = sd_biasp_falling./sqrt(number_SEM_falling);

SEM_biasp_falling(number_SEM_falling<=1) = NaN;
[ci_biasp_lower_falling_90, ci_biasp_upper_falling_90, ...
 ci_biasp_lower_falling,    ci_biasp_upper_falling, ...
 ci_biasp_lower_falling_99, ci_biasp_upper_falling_99, ...
 sig_biasp_falling] = make_ci_and_sig(biasp_falling, SEM_biasp_falling, number_SEM_falling-1);

% Wave specific error metrics
rmse_wave = NaN(8,pre_length);
rmsep_wave = NaN(8,pre_length);
bias_wave = NaN(8,pre_length);
biasp_wave = NaN(8,pre_length);
sd_bias_wave = NaN(8,pre_length);
sd_biasp_wave = NaN(8,pre_length);
SEM_bias_wave = NaN(8,pre_length);
SEM_biasp_wave = NaN(8,pre_length);

ci_bias_lower_wave = NaN(8,pre_length);
ci_bias_upper_wave = NaN(8,pre_length);
ci_biasp_lower_wave = NaN(8,pre_length);
ci_biasp_upper_wave = NaN(8,pre_length);

%count number of samples by wave
wave_num = NaN(8,pre_length);
sig_biasp_wave = strings(8,pre_length);

%Metrics of waves
for i = 4: 8
rmse_wave(i,:) = sqrt (mean (TT(TT.wave == i, :).error_square,'omitnan'));
rmsep_wave(i,:) = sqrt (mean (TT(TT.wave == i, :).errorp_square,'omitnan'));

bias_wave(i,:) = mean (TT(TT.wave == i, :).error,'omitnan');
biasp_wave(i,:) = mean (TT(TT.wave == i, :).errorp,'omitnan');

sd_bias_wave(i,:) = sqrt(mean((TT(TT.wave == i,:).error - bias_wave(i,:)).^2,'omitnan'));
sd_biasp_wave(i,:) = sqrt(mean((TT(TT.wave == i,:).errorp - biasp_wave(i,:)).^2,'omitnan'));

number_SEM_wave = zeros(1,length(sd_bias_wave(i,:)));

  for c = 1:length(sd_bias_wave(i,:))
  number_SEM_wave(c) = sum(~isnan(TT(TT.wave == i, :).errorp(:,c))); %
  end 

SEM_bias_wave(i,:) = sd_bias_wave(i,:)./sqrt(number_SEM_wave);

ci_bias_lower_wave(i,:) = bias_wave(i,:) - 1.96 * SEM_bias_wave(i,:);

ci_bias_upper_wave(i,:) = bias_wave(i,:) + 1.96 * SEM_bias_wave(i,:);


sd_biasp_wave(i,:) = sd_biasp_wave(i,:) .* sqrt(number_SEM_wave ./ max(number_SEM_wave-1,1));
SEM_biasp_wave(i,:) = sd_biasp_wave(i,:)./sqrt(number_SEM_wave);
SEM_biasp_wave(i, number_SEM_wave<=1) = NaN;
[ci_biasp_lower_wave_90_i, ci_biasp_upper_wave_90_i, ...
 ci_biasp_lower_wave_i,    ci_biasp_upper_wave_i, ...
 ci_biasp_lower_wave_99_i, ci_biasp_upper_wave_99_i, ...
 sig_biasp_wave_i] = make_ci_and_sig(biasp_wave(i,:), SEM_biasp_wave(i,:), number_SEM_wave-1);

ci_biasp_lower_wave(i,:) = ci_biasp_lower_wave_i;
ci_biasp_upper_wave(i,:) = ci_biasp_upper_wave_i;
sig_biasp_wave(i,:)      = sig_biasp_wave_i;

%ci_bias_wave = [ci_bias_lower_wave;ci_bias_upper_wave]

    for k = 1:pre_length
    wave_num(i,k) = sum((~isnan(TT(TT.wave == i, :).error(:,k))));
    end
end



%fill big timetable
BTT(j).TT = TT;
BTT(j).rmse_all = rmse_all;
BTT(j).rmse_rising = rmse_rising;
BTT(j).rmse_peak = rmse_peak;
BTT(j).rmse_falling = rmse_falling;
BTT(j).rmse_wave = rmse_wave;

BTT(j).rmsep_all = rmsep_all;
BTT(j).rmsep_rising = rmsep_rising;
BTT(j).rmsep_peak = rmsep_peak;
BTT(j).rmsep_falling = rmsep_falling;
BTT(j).rmsep_wave = rmsep_wave;

BTT(j).bias_all = bias_all;
BTT(j).bias_rising = bias_rising;
BTT(j).bias_peak = bias_peak;
BTT(j).bias_falling = bias_falling;
BTT(j).bias_wave = bias_wave;

BTT(j).biasp_all = biasp_all;
BTT(j).biasp_rising = biasp_rising;
BTT(j).biasp_peak = biasp_peak;
BTT(j).biasp_falling = biasp_falling;
BTT(j).biasp_wave = biasp_wave;

BTT(j).all_num = all_num;
BTT(j).wave_num = wave_num;
BTT(j).phase_num = phase_num;

BTT(j).sig_biasp_all = sig_biasp_all;
BTT(j).sig_biasp_rising = sig_biasp_rising;
BTT(j).sig_biasp_peak = sig_biasp_peak;
BTT(j).sig_biasp_falling = sig_biasp_falling;
BTT(j).sig_biasp_wave = sig_biasp_wave;

 if j == 1
 BTT(j).ci_bias_all = transpose(ci_bias_all(:,[1,8,22]));
 BTT(j).ci_biasp_all = transpose(ci_biasp_all(:,[1,8,22]));
 BTT(j).ci_bias_upper_wave = transpose(ci_bias_upper_wave(:,[1,8,22]));
 BTT(j).ci_bias_lower_wave = transpose(ci_bias_lower_wave(:,[1,8,22]));
 BTT(j).ci_biasp_upper_wave = transpose(ci_biasp_upper_wave(:,[1,8,22]));
 BTT(j).ci_biasp_lower_wave = transpose(ci_biasp_lower_wave(:,[1,8,22])); 
 BTT(j).ci_biasp_lower_rising = ci_biasp_lower_rising([1,8,22]);
 BTT(j).ci_biasp_upper_rising = ci_biasp_upper_rising([1,8,22]);
 BTT(j).ci_biasp_lower_peak = ci_biasp_lower_peak([1,8,22]);
 BTT(j).ci_biasp_upper_peak = ci_biasp_upper_peak([1,8,22]);
 BTT(j).ci_biasp_lower_falling = ci_biasp_lower_falling([1,8,22]);
 BTT(j).ci_biasp_upper_falling = ci_biasp_upper_falling([1,8,22]);
 elseif j == 2
 BTT(j).ci_bias_all = transpose(ci_bias_all(:,1));
 BTT(j).ci_biasp_all = transpose(ci_biasp_all(:,1));
 BTT(j).ci_bias_upper_wave = transpose(ci_bias_upper_wave(:,1));
 BTT(j).ci_bias_lower_wave = transpose(ci_bias_lower_wave(:,1));
 BTT(j).ci_biasp_upper_wave = transpose(ci_biasp_upper_wave(:,1));
 BTT(j).ci_biasp_lower_wave = transpose(ci_biasp_lower_wave(:,1));
 BTT(j).ci_biasp_lower_rising = ci_biasp_lower_rising;
 BTT(j).ci_biasp_upper_rising = ci_biasp_upper_rising;
 BTT(j).ci_biasp_lower_peak = ci_biasp_lower_peak;
 BTT(j).ci_biasp_upper_peak = ci_biasp_upper_peak;
 BTT(j).ci_biasp_lower_falling = ci_biasp_lower_falling;
 BTT(j).ci_biasp_upper_falling = ci_biasp_upper_falling;
 elseif j == 3
 BTT(j).ci_bias_all = transpose(ci_bias_all(:,[1,2,4]));
 BTT(j).ci_biasp_all = transpose(ci_biasp_all(:,[1,2,4]));
 BTT(j).ci_bias_upper_wave = transpose(ci_bias_upper_wave(:,[1,2,4]));
 BTT(j).ci_bias_lower_wave = transpose(ci_bias_lower_wave(:,[1,2,4]));
 BTT(j).ci_biasp_upper_wave = transpose(ci_biasp_upper_wave(:,[1,2,4]));
 BTT(j).ci_biasp_lower_wave = transpose(ci_biasp_lower_wave(:,[1,2,4]));
 BTT(j).ci_biasp_lower_rising = ci_biasp_lower_rising([1,2,4]);
 BTT(j).ci_biasp_upper_rising = ci_biasp_upper_rising([1,2,4]);
 BTT(j).ci_biasp_lower_peak = ci_biasp_lower_peak([1,2,4]);
 BTT(j).ci_biasp_upper_peak = ci_biasp_upper_peak([1,2,4]);
 BTT(j).ci_biasp_lower_falling = ci_biasp_lower_falling([1,2,4]);
 BTT(j).ci_biasp_upper_falling = ci_biasp_upper_falling([1,2,4]);
 elseif j == 4
 BTT(j).ci_bias_all = transpose(ci_bias_all(:,[7,14,28]));
 BTT(j).ci_biasp_all = transpose(ci_biasp_all(:,[7,14,28]));
 BTT(j).ci_bias_upper_wave = transpose(ci_bias_upper_wave(:,[7,14,28]));
 BTT(j).ci_bias_lower_wave = transpose(ci_bias_lower_wave(:,[7,14,28]));
 BTT(j).ci_biasp_upper_wave = transpose(ci_biasp_upper_wave(:,[7,14,28]));
 BTT(j).ci_biasp_lower_wave = transpose(ci_biasp_lower_wave(:,[7,14,28]));
 BTT(j).ci_biasp_lower_rising = ci_biasp_lower_rising([7,14,28]);
 BTT(j).ci_biasp_upper_rising = ci_biasp_upper_rising([7,14,28]);
 BTT(j).ci_biasp_lower_peak = ci_biasp_lower_peak([7,14,28]);
 BTT(j).ci_biasp_upper_peak = ci_biasp_upper_peak([7,14,28]);
 BTT(j).ci_biasp_lower_falling = ci_biasp_lower_falling([7,14,28]);
 BTT(j).ci_biasp_upper_falling = ci_biasp_upper_falling([7,14,28]);
 elseif j == 5
 BTT(j).ci_bias_all = transpose(ci_bias_all(:,[7,14,28]));
 BTT(j).ci_biasp_all = transpose(ci_biasp_all(:,[7,14,28]));
 BTT(j).ci_bias_upper_wave = transpose(ci_bias_upper_wave(:,[7,14,28]));
 BTT(j).ci_bias_lower_wave = transpose(ci_bias_lower_wave(:,[7,14,28]));
 BTT(j).ci_biasp_upper_wave = transpose(ci_biasp_upper_wave(:,[7,14,28]));
 BTT(j).ci_biasp_lower_wave = transpose(ci_biasp_lower_wave(:,[7,14,28]));
 BTT(j).ci_biasp_lower_rising = ci_biasp_lower_rising([7,14,28]);
 BTT(j).ci_biasp_upper_rising = ci_biasp_upper_rising([7,14,28]);
 BTT(j).ci_biasp_lower_peak = ci_biasp_lower_peak([7,14,28]);
 BTT(j).ci_biasp_upper_peak = ci_biasp_upper_peak([7,14,28]);
 BTT(j).ci_biasp_lower_falling = ci_biasp_lower_falling([7,14,28]);
 BTT(j).ci_biasp_upper_falling = ci_biasp_upper_falling([7,14,28]);
 end

fig_name_2 = "_spaghetti_by_phase_ma_peakpm7";
fig_name = sprintf('%s%s',projectionname(j),fig_name_2);


%save figures
if figure_save
    cd('spaghetti_chart/')
    saveas(fig_phase,fig_name,'png');
    cd(home)
    
end

end


%% 

indicator = zeros(900,5);

project_date = days(find(~isnan(BTT(1).TT.pre_path(:,1)))) - 2 +  BTT(1).TT.date_dt(1);

for n = 1:5
    ind = ~isnan(BTT(n).TT.pre_path(:,1));
    
    if n ==1|| n ==2
        project_date = days(find(~isnan(BTT(n).TT.pre_path(:,1)))) - 7 +  BTT(n).TT.date_dt(1);
    elseif n == 3
        project_date = days(7*(find(~isnan(BTT(n).TT.pre_path(:,1))) - 1 )  )  +  BTT(n).TT.date_dt(1);
    elseif n == 5 
        project_date = days(find(~isnan(BTT(n).TT.pre_path(:,7)))) - 1 +  BTT(n).TT.date_dt(1);
    elseif n == 4 
        project_date = days(find(~isnan(BTT(n).TT.pre_path(:,1)))) - 1 +  BTT(n).TT.date_dt(1);
    end
    initial_diff = days(project_date - datetime('2021/01/01', 'InputFormat', 'yyyy/MM/dd'));
    indicator(initial_diff,n) =1; 
end

%2 weeks indicator
project_date_2week = days(find(~isnan(BTT(1).TT.pre_path(:,1)))) - 2 +  BTT(1).TT.date_dt(1);

indicator_2week = zeros(900,5);
for n = [1,3,4,5]
    ind = ~isnan(BTT(n).TT.pre_path(:,1));
    
    if n == 1
        project_date_2week = days(find(~isnan(BTT(n).TT.pre_path(:,8)))) - 7 +  BTT(n).TT.date_dt(1);
%    elseif n == 2
%        project_date_2week = days(BTT(n).TT.date_dt -  BTT(n).TT.date_dt);
    elseif n == 3
        project_date_2week = days(7*(find(~isnan(BTT(n).TT.pre_path(:,2))) - 1 )  )  +  BTT(n).TT.date_dt(1);
    elseif n == 5 
        project_date_2week = days(find(~isnan(BTT(n).TT.pre_path(:,14)))) - 1 +  BTT(n).TT.date_dt(1);
    elseif n == 4 
        project_date_2week = days(find(~isnan(BTT(n).TT.pre_path(:,14)))) - 1 +  BTT(n).TT.date_dt(1);
    end
    initial_diff_2week = days(project_date_2week - datetime('2021/01/01', 'InputFormat', 'yyyy/MM/dd'));
    indicator_2week(initial_diff_2week,n) =1; 
end

%4 weeks indicator
project_date_4week = days(find(~isnan(BTT(1).TT.pre_path(:,1)))) - 2 +  BTT(1).TT.date_dt(1);

indicator_4week = zeros(900,5);
for n = [1,3,4,5]
    ind = ~isnan(BTT(n).TT.pre_path(:,1));
    
    if n == 1
        project_date_4week = days(find(~isnan(BTT(n).TT.pre_path(:,22)))) - 7 +  BTT(n).TT.date_dt(1);
%    elseif n == 2
%        project_date_2week = days(BTT(n).TT.date_dt -  BTT(n).TT.date_dt);
    elseif n == 3
        project_date_4week = days(7*(find(~isnan(BTT(n).TT.pre_path(:,4))) - 1 )  )  +  BTT(n).TT.date_dt(1);
    elseif n == 5 
        project_date_4week = days(find(~isnan(BTT(n).TT.pre_path(:,28)))) - 1 +  BTT(n).TT.date_dt(1);
    elseif n == 4 
        project_date_4week = days(find(~isnan(BTT(n).TT.pre_path(:,28)))) - 1 +  BTT(n).TT.date_dt(1);
    end
    initial_diff_4week = days(project_date_4week - datetime('2021/01/01', 'InputFormat', 'yyyy/MM/dd'));
    indicator_4week(initial_diff_4week,n) =1; 
end

indlength = transpose([0:899]);
date_ind = indlength + datetime('2021/01/01', 'InputFormat', 'yyyy/MM/dd');

ind_3_2 = indicator(:,2);
ind_3_3_A = indicator(:,1);
ind_FN = indicator(:,3);
ind_Hirata = indicator(:,4);
ind_CATs = indicator(:,5);

ind_3_2_2week = indicator_2week(:,2);
ind_3_3_A_2week = indicator_2week(:,1);
ind_FN_2week = indicator_2week(:,3);
ind_Hirata_2week = indicator_2week(:,4);
ind_CATs_2week = indicator_2week(:,5);

ind_3_2_4week = indicator_4week(:,2);
ind_3_3_A_4week = indicator_4week(:,1);
ind_FN_4week = indicator_4week(:,3);
ind_Hirata_4week = indicator_4week(:,4);
ind_CATs_4week = indicator_4week(:,5);

ind_total = indicator(:,1) + indicator(:,2) + indicator(:,3) + indicator(:,4) + indicator(:,5);

ind_total_win = zeros(900,1);

%calculate indicator of 3-day window
for d = 1 : 900
    if d == 1 
    ind_total_win(d) = ind_total(d) + ind_total(d+1);
    elseif d == 900
    ind_total_win(d) = ind_total(d) + ind_total(d-1);
    else
    ind_total_win(d) = ind_total(d) + ind_total(d-1) + ind_total(d+1) - ...
    ind_CATs(d-1) - ind_CATs(d) - ind_CATs(d + 1) + ((sum(ind_CATs((d-1):d+1)))~=0);
    end

end


ind_total_2week = indicator_2week(:,1) + indicator_2week(:,2) + indicator_2week(:,3)...
    + indicator_2week(:,4) + indicator_2week(:,5);

ind_total_4week = indicator_4week(:,1) + indicator_4week(:,2) + indicator_4week(:,3)...
    + indicator_4week(:,4) + indicator_4week(:,5);


    % Define troughs and peaks
    troughs = [ ...
    datetime('2021-08-5','InputFormat','yyyy-MM-dd'), ...
    datetime('2021-11-28','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-06-16','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-10-11','InputFormat','yyyy-MM-dd'), ...
    datetime('2023-03-22','InputFormat','yyyy-MM-dd')];
    peaks = [ ...
    datetime('2021-08-19','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-02-08','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-08-03','InputFormat','yyyy-MM-dd'), ...
    datetime('2022-12-27','InputFormat','yyyy-MM-dd') ];

    wave_initial = 5; %Hirata

ind_wave_avg = NaN(900,1);

for i = 1:numel(peaks)
    peak_current = peaks(i);

    trough_current = troughs(i);
  
    % Mark falling phase
    trough_next = troughs(i+1);
    ind_wave = (date_ind >= trough_current) & (date_ind <= trough_next);
    ind_wave_avg(ind_wave) = i + wave_initial - 1; 
end

matrix_index = timetable(date_ind, ind_3_2, ind_3_3_A, ind_FN ...
    ,ind_Hirata, ind_CATs, ind_total,ind_wave_avg, ind_total_win, ind_3_2_2week, ind_3_3_A_2week, ind_FN_2week ...
    , ind_Hirata_2week, ind_CATs_2week, ind_total_2week ...
    ,ind_3_2_4week, ind_3_3_A_4week, ind_FN_4week ...
    , ind_Hirata_4week, ind_CATs_4week,ind_total_4week);

%record the date which has more than 1 projection were released
date_savg_2 = find(ind_total > 1) + datetime('2021/01/01', 'InputFormat', 'yyyy/MM/dd');

%record the matrix only inclue the date which has more than 1 projection were released

matrix_savg_2 = matrix_index(find(ind_total > 1),:);

simple_avg = zeros(sum(ind_total > 1),3);

simple_avg_2 = timetable(date_savg_2,simple_avg);

 

%For each date, find which 1 week ahead projection is available
for p = 1 : sum(ind_total > 1)
%for p = 1 : 5
    %for q = 2 : 6
    
    sum_avg = 0;
        if matrix_savg_2.ind_3_3_A(p) %3-3
    sum_avg = sum_avg + ...
    BTT(1).TT(find(BTT(1).TT.date_dt==date_savg_2(p)) + 6,:).pre_path(1);
        end
        if matrix_savg_2.ind_3_2(p) %3-2
    sum_avg = sum_avg + ...
    BTT(2).TT(find(BTT(2).TT.date_dt==date_savg_2(p)) + 6,:).pre_path(1);
        end
        if matrix_savg_2.ind_FN(p) %FN
    sum_avg = sum_avg + ...
    BTT(3).TT(find(BTT(3).TT.date_dt==date_savg_2(p)) ,:).pre_path(1);
        end
        if matrix_savg_2.ind_Hirata(p) %Hirata
    sum_avg = sum_avg + ...
    BTT(4).TT(find(BTT(4).TT.date_dt==date_savg_2(p)),:).pre_path(7);
        end
        if matrix_savg_2.ind_CATs(p) %CATs
    sum_avg = sum_avg + ...
    BTT(5).TT(find(BTT(5).TT.date_dt==date_savg_2(p)),:).pre_path(7);
        end
    
    
    simple_avg(p,1) = sum_avg/matrix_savg_2.ind_total(p);
    
end



%Record date for 2 week projection
date_ind_2week = matrix_savg_2.date_ind(matrix_savg_2.ind_total_2week> 1);
ind_2week = matrix_savg_2.ind_total_2week > 1;


count2week = 1;
%while count2week <= 3
while count2week <= length(ind_2week)
    sum_avg = 0;
     if ind_2week(count2week) == 1
        
        if matrix_savg_2.ind_3_3_A_2week(count2week) %3-3
    sum_avg = sum_avg + ...
    BTT(1).TT(find(BTT(1).TT.date_dt == date_savg_2(count2week)) + 6,:).pre_path(8);
        end
        if matrix_savg_2.ind_FN_2week(count2week) %FN
    sum_avg = sum_avg + ...
    BTT(3).TT(find(BTT(3).TT.date_dt == date_savg_2(count2week)) ,:).pre_path(2);
        end
        if matrix_savg_2.ind_Hirata_2week(count2week) %Hirata
    sum_avg = sum_avg + ...
    BTT(4).TT(find(BTT(4).TT.date_dt == date_savg_2(count2week)),:).pre_path(14);
        end
        if matrix_savg_2.ind_CATs_2week(count2week) %CATs
    sum_avg = sum_avg + ...
    BTT(5).TT(find(BTT(5).TT.date_dt == date_savg_2(count2week)),:).pre_path(14);
        end

    simple_avg(count2week,2) = sum_avg/matrix_savg_2.ind_total_2week(count2week);
    end
    count2week = count2week+1;
end

simple_avg;

%Record date for 4-week projection
date_ind_4week = matrix_savg_2.date_ind(matrix_savg_2.ind_total_4week> 1);
ind_4week = matrix_savg_2.ind_total_4week > 1;


count4week = 1;
%while count4week <= 3
while count4week <= length(ind_4week)
    sum_avg = 0;
     if ind_4week(count4week) == 1
        
        if matrix_savg_2.ind_3_3_A_4week(count4week) %3-3
    sum_avg = sum_avg + ...
    BTT(1).TT(find(BTT(1).TT.date_dt == date_savg_2(count4week)) + 6,:).pre_path(22);
        end
        if matrix_savg_2.ind_FN_4week(count4week) %FN
    sum_avg = sum_avg + ...
    BTT(3).TT(find(BTT(3).TT.date_dt == date_savg_2(count4week)) ,:).pre_path(4);
        end
        if matrix_savg_2.ind_Hirata_4week(count4week) %Hirata
    sum_avg = sum_avg + ...
    BTT(4).TT(find(BTT(4).TT.date_dt == date_savg_2(count4week)),:).pre_path(28);
        end
        if matrix_savg_2.ind_CATs_4week(count4week) %CATs
    sum_avg = sum_avg + ...
    BTT(5).TT(find(BTT(5).TT.date_dt == date_savg_2(count4week)),:).pre_path(28);
        end

    simple_avg(count4week,3) = sum_avg/matrix_savg_2.ind_total_4week(count4week);
    end
    count4week = count4week+1;
end

simple_avg;

simple_avg_1_week = simple_avg(:,1);
simple_avg_2_week = simple_avg(:,2);
simple_avg_4_week = simple_avg(:,3);

num_total_1_week = matrix_savg_2.ind_total;
num_total_2_week = matrix_savg_2.ind_total_2week;
num_total_4_week = matrix_savg_2.ind_total_4week;

num_avg_1_week = sum(num_total_1_week > 1);
num_avg_2_week = sum(num_total_2_week > 1);
num_avg_4_week = sum(num_total_4_week > 1);

%load actual of date which we have simple average

actual_path_avg = NaN(length(date_savg_2),3);

target1 = date_savg_2 + days(8);
target2 = date_savg_2 + days(15);
target3 = date_savg_2 + days(29);

[tf1, loc1] = ismember(target1, BTT(4).TT.date_dt);
[tf2, loc2] = ismember(target2, BTT(4).TT.date_dt);
[tf3, loc3] = ismember(target3, BTT(4).TT.date_dt);

actual_path_avg(tf1,1) = BTT(4).TT.actual(loc1(tf1));
actual_path_avg(tf2,2) = BTT(4).TT.actual(loc2(tf2));
actual_path_avg(tf3,3) = BTT(4).TT.actual(loc3(tf3));

%load predicted path
pre_path_avg = NaN(length(date_savg_2),3);
pre_path_avg(:,1) = simple_avg_1_week;
pre_path_avg(:,2) = simple_avg_2_week;
pre_path_avg(:,3) = simple_avg_4_week;

%error metrics
error_avg = pre_path_avg - actual_path_avg;
error_square_avg = error_avg.^2;
errorp_avg = (pre_path_avg - actual_path_avg)./actual_path_avg;
errorp_square_avg = errorp_avg.^2;

simple_avg_table = timetable(date_savg_2,simple_avg_1_week,num_total_1_week, ...
    simple_avg_2_week, ...
    num_total_2_week,simple_avg_4_week,num_total_4_week, ...
    actual_path_avg,pre_path_avg, error_avg,error_square_avg, errorp_avg,errorp_square_avg);

pre_path_avg(find(pre_path_avg==0))= NaN;

%error metrics
error_avg = pre_path_avg - actual_path_avg;
error_square_avg = error_avg.^2;
errorp_avg = (pre_path_avg - actual_path_avg)./actual_path_avg;
errorp_square_avg = errorp_avg.^2;
%rmse
rmse_avg = sqrt (mean (error_square_avg,'omitnan'));
%rmsep
rmsep_avg = sqrt (mean (errorp_square_avg,'omitnan'));
%bias
bias_avg = mean (error_avg,'omitnan');
%biasp
biasp_avg = mean (errorp_avg,'omitnan');

error_matrics = struct('rmse_avg',[rmse_avg],'rmsep_avg',[rmsep_avg],'bias_avg' ...
    ,[bias_avg],'biasp_avg',[biasp_avg])

%% save data 
%This is a sample that we export data from the tables

errorp_3_3_A = BTT(1).TT(BTT(1).TT.wave==4,:).errorp(...
find(~isnan(BTT(1).TT(BTT(1).TT.wave==4,:).errorp(:,1))),1);

date_3_3_A = BTT(1).TT(BTT(1).TT.wave==4,:). ...
date_dt(find(~isnan(BTT(1).TT(BTT(1).TT.wave==4,:).errorp(:,1))));

data = table([date_3_3_A] ...
   ,[errorp_3_3_A], ...
   'VariableNames',{'date_4th_wave', '1 week errorp'});


%% 
 errorp_3_2 = BTT(2).TT.errorp(find(~isnan(BTT(2).TT.errorp(:,1))),1);
 length(errorp_3_2);
 
 %SD of errorp
 sd = sqrt(mean((errorp_3_2- mean(errorp_3_2)).^2));
 sdsm = sd/sqrt(length(errorp_3_2))
 ci_biasp = [mean(errorp_3_2)-1.96*sdsm, mean(errorp_3_2) + 1.96*sdsm];

 results_ci = [mean(errorp_3_2),sdsm,ci_biasp]
 error_3_2 = BTT(2).TT.error(find(~isnan(BTT(2).TT.error(:,1))),1);
 length(error_3_2);

%SD of error
sd_bias = sqrt(mean((error_3_2 - mean(error_3_2)).^2));
sdsm_bias = sd_bias/sqrt(length(error_3_2));
%1.96
ci_bias = [mean(error_3_2)-1.96*sdsm_bias, mean(error_3_2) + 1.96*sdsm_bias];


%% 

%%%%%%%%  Print table in .tex

fid = fopen('Table_peakpm7.txt', 'w');

% =========================================================
% Common horizon mapping across the 5 projections
% row 1 = one week, row 2 = two weeks, row 3 = four weeks
% columns: [AB 3-3, AB 3-2, Fujii-Nakata, Hirata, CATs]
% =========================================================
HMAP = [ ...
     1,   1,   1,   7,   7;   % One week
     8, NaN,   2,  14,  14;   % Two weeks
    22, NaN,   4,  28,  28];  % Four weeks

horizon_labels_common = {'One week','Two weeks','Four weeks'};
wave_names = ["","","","Fourth wave","Fifth wave","Sixth wave","Seventh wave","Eighth wave"];
phase_names = ["rising","peak","falling"];

%% -------------------------
%% Entire samples
%% -------------------------
begin_table_simple(fid, 'Error metrics: entire samples', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

print_group_rows(fid, 'AB 3-2', ...
    {'One week'}, ...
    BTT(2).rmsep_all([1])*100, ...
    BTT(2).biasp_all([1])*100, ...
    BTT(2).sig_biasp_all([1]), ...
    BTT(2).all_num([1]));

print_group_rows(fid, 'AB 3-3', ...
    {'One week','Two weeks','Four weeks'}, ...
    BTT(1).rmsep_all([1,8,22])*100, ...
    BTT(1).biasp_all([1,8,22])*100, ...
    BTT(1).sig_biasp_all([1,8,22]), ...
    BTT(1).all_num([1,8,22]));

print_group_rows(fid, 'Fujii-Nakata', ...
    {'One week','Two weeks','Four weeks'}, ...
    BTT(3).rmsep_all([1,2,4])*100, ...
    BTT(3).biasp_all([1,2,4])*100, ...
    BTT(3).sig_biasp_all([1,2,4]), ...
    BTT(3).all_num([1,2,4]));

print_group_rows(fid, 'Hirata', ...
    {'One week','Two weeks','Four weeks'}, ...
    BTT(4).rmsep_all([7,14,28])*100, ...
    BTT(4).biasp_all([7,14,28])*100, ...
    BTT(4).sig_biasp_all([7,14,28]), ...
    BTT(4).all_num([7,14,28]));

print_group_rows(fid, 'CATs', ...
    {'One week','Two weeks','Four weeks'}, ...
    BTT(5).rmsep_all([7,14,28])*100, ...
    BTT(5).biasp_all([7,14,28])*100, ...
    BTT(5).sig_biasp_all([7,14,28]), ...
    BTT(5).all_num([7,14,28]));

add_sig_note_compact(fid, 4);
end_table_simple(fid);

%% --------------------------------
%% Weighted average across projections: entire samples
%% --------------------------------
w_biasp_all = NaN(1,3);
w_rmsep_all = NaN(1,3);
w_N_all     = NaN(1,3);
w_sig_all   = strings(1,3);

for hh = 1:3
    vec = collect_errorp_all(BTT, HMAP(hh,:));
    [w_biasp_all(hh), w_rmsep_all(hh), w_N_all(hh), w_sig_all(hh)] = pooled_metrics_from_errorp(vec);
end

begin_table_simple(fid, 'Weighted average error metrics across projections: entire samples', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

print_group_rows_valid(fid, 'Weighted average across projections', ...
    horizon_labels_common, ...
    w_rmsep_all * 100, ...
    w_biasp_all * 100, ...
    w_sig_all, ...
    w_N_all);

add_sig_note_compact(fid, 4);
end_table_simple(fid);


%% --------------------------------
%% Wave-by-wave tables by projection
%% --------------------------------
begin_table_simple(fid, 'Error metrics of AB 3-2: wave by wave', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');
print_group_rows(fid, 'Sixth wave',   {'One week'}, BTT(2).rmsep_wave(6,[1])*100, BTT(2).biasp_wave(6,[1])*100, BTT(2).sig_biasp_wave(6,[1]), BTT(2).wave_num(6,[1]));
print_group_rows(fid, 'Seventh wave', {'One week'}, BTT(2).rmsep_wave(7,[1])*100, BTT(2).biasp_wave(7,[1])*100, BTT(2).sig_biasp_wave(7,[1]), BTT(2).wave_num(7,[1]));
print_group_rows(fid, 'Eighth wave',  {'One week'}, BTT(2).rmsep_wave(8,[1])*100, BTT(2).biasp_wave(8,[1])*100, BTT(2).sig_biasp_wave(8,[1]), BTT(2).wave_num(8,[1]));
add_sig_note_compact(fid, 4);
end_table_simple(fid);

begin_table_simple(fid, 'Error metrics of AB 3-3: wave by wave', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');
print_group_rows(fid, 'Fourth wave',  {'One week'}, BTT(1).rmsep_wave(4,[1])*100,     BTT(1).biasp_wave(4,[1])*100,     BTT(1).sig_biasp_wave(4,[1]),     BTT(1).wave_num(4,[1]));
print_group_rows(fid, 'Fifth wave',   {'One week','Two weeks','Four weeks'}, BTT(1).rmsep_wave(5,[1,8,22])*100, BTT(1).biasp_wave(5,[1,8,22])*100, BTT(1).sig_biasp_wave(5,[1,8,22]), BTT(1).wave_num(5,[1,8,22]));
print_group_rows(fid, 'Sixth wave',   {'One week','Two weeks','Four weeks'}, BTT(1).rmsep_wave(6,[1,8,22])*100, BTT(1).biasp_wave(6,[1,8,22])*100, BTT(1).sig_biasp_wave(6,[1,8,22]), BTT(1).wave_num(6,[1,8,22]));
print_group_rows(fid, 'Seventh wave', {'One week','Two weeks','Four weeks'}, BTT(1).rmsep_wave(7,[1,8,22])*100, BTT(1).biasp_wave(7,[1,8,22])*100, BTT(1).sig_biasp_wave(7,[1,8,22]), BTT(1).wave_num(7,[1,8,22]));
print_group_rows(fid, 'Eighth wave',  {'One week','Two weeks','Four weeks'}, BTT(1).rmsep_wave(8,[1,8,22])*100, BTT(1).biasp_wave(8,[1,8,22])*100, BTT(1).sig_biasp_wave(8,[1,8,22]), BTT(1).wave_num(8,[1,8,22]));
add_sig_note_compact(fid, 4);
end_table_simple(fid);

begin_table_simple(fid, 'Error metrics of Fujii-Nakata: wave by wave', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');
print_group_rows(fid, 'Fourth wave',  {'One week','Two weeks','Four weeks'}, BTT(3).rmsep_wave(4,[1,2,4])*100, BTT(3).biasp_wave(4,[1,2,4])*100, BTT(3).sig_biasp_wave(4,[1,2,4]), BTT(3).wave_num(4,[1,2,4]));
print_group_rows(fid, 'Fifth wave',   {'One week','Two weeks','Four weeks'}, BTT(3).rmsep_wave(5,[1,2,4])*100, BTT(3).biasp_wave(5,[1,2,4])*100, BTT(3).sig_biasp_wave(5,[1,2,4]), BTT(3).wave_num(5,[1,2,4]));
print_group_rows(fid, 'Sixth wave',   {'One week','Two weeks','Four weeks'}, BTT(3).rmsep_wave(6,[1,2,4])*100, BTT(3).biasp_wave(6,[1,2,4])*100, BTT(3).sig_biasp_wave(6,[1,2,4]), BTT(3).wave_num(6,[1,2,4]));
print_group_rows(fid, 'Seventh wave', {'One week','Two weeks','Four weeks'}, BTT(3).rmsep_wave(7,[1,2,4])*100, BTT(3).biasp_wave(7,[1,2,4])*100, BTT(3).sig_biasp_wave(7,[1,2,4]), BTT(3).wave_num(7,[1,2,4]));
print_group_rows(fid, 'Eighth wave',  {'One week','Two weeks','Four weeks'}, BTT(3).rmsep_wave(8,[1,2,4])*100, BTT(3).biasp_wave(8,[1,2,4])*100, BTT(3).sig_biasp_wave(8,[1,2,4]), BTT(3).wave_num(8,[1,2,4]));
add_sig_note_compact(fid, 4);
end_table_simple(fid);

begin_table_simple(fid, 'Error metrics of Hirata: wave by wave', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');
print_group_rows(fid, 'Fifth wave',   {'One week','Two weeks','Four weeks'}, BTT(4).rmsep_wave(5,[7,14,28])*100, BTT(4).biasp_wave(5,[7,14,28])*100, BTT(4).sig_biasp_wave(5,[7,14,28]), BTT(4).wave_num(5,[7,14,28]));
print_group_rows(fid, 'Sixth wave',   {'One week','Two weeks','Four weeks'}, BTT(4).rmsep_wave(6,[7,14,28])*100, BTT(4).biasp_wave(6,[7,14,28])*100, BTT(4).sig_biasp_wave(6,[7,14,28]), BTT(4).wave_num(6,[7,14,28]));
print_group_rows(fid, 'Seventh wave', {'One week','Two weeks','Four weeks'}, BTT(4).rmsep_wave(7,[7,14,28])*100, BTT(4).biasp_wave(7,[7,14,28])*100, BTT(4).sig_biasp_wave(7,[7,14,28]), BTT(4).wave_num(7,[7,14,28]));
print_group_rows(fid, 'Eighth wave',  {'One week','Two weeks','Four weeks'}, BTT(4).rmsep_wave(8,[7,14,28])*100, BTT(4).biasp_wave(8,[7,14,28])*100, BTT(4).sig_biasp_wave(8,[7,14,28]), BTT(4).wave_num(8,[7,14,28]));
add_sig_note_compact(fid, 4);
end_table_simple(fid);

begin_table_simple(fid, 'Error metrics of CATs: wave by wave', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');
print_group_rows(fid, 'Sixth wave',   {'One week','Two weeks','Four weeks'}, BTT(5).rmsep_wave(6,[7,14,28])*100, BTT(5).biasp_wave(6,[7,14,28])*100, BTT(5).sig_biasp_wave(6,[7,14,28]), BTT(5).wave_num(6,[7,14,28]));
print_group_rows(fid, 'Seventh wave', {'One week','Two weeks','Four weeks'}, BTT(5).rmsep_wave(7,[7,14,28])*100, BTT(5).biasp_wave(7,[7,14,28])*100, BTT(5).sig_biasp_wave(7,[7,14,28]), BTT(5).wave_num(7,[7,14,28]));
print_group_rows(fid, 'Eighth wave',  {'One week','Two weeks','Four weeks'}, BTT(5).rmsep_wave(8,[7,14,28])*100, BTT(5).biasp_wave(8,[7,14,28])*100, BTT(5).sig_biasp_wave(8,[7,14,28]), BTT(5).wave_num(8,[7,14,28]));
add_sig_note_compact(fid, 4);
end_table_simple(fid);

%% --------------------------------
%% Weighted average wave-by-wave table across projections
%% --------------------------------
begin_table_simple(fid, 'Weighted average error metrics across projections: wave by wave', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

for wave_id = 4:8
    w_biasp_wave = NaN(1,3);
    w_rmsep_wave = NaN(1,3);
    w_N_wave     = NaN(1,3);
    w_sig_wave   = strings(1,3);

    for hh = 1:3
        vec = collect_errorp_wave(BTT, HMAP(hh,:), wave_id);
        [w_biasp_wave(hh), w_rmsep_wave(hh), w_N_wave(hh), w_sig_wave(hh)] = pooled_metrics_from_errorp(vec);
    end

    print_group_rows_valid(fid, char(wave_names(wave_id)), ...
        horizon_labels_common, ...
        w_rmsep_wave * 100, ...
        w_biasp_wave * 100, ...
        w_sig_wave, ...
        w_N_wave);
end

add_sig_note_compact(fid, 4);
end_table_simple(fid);

%% --------------------------------
%% Combined phase summary across projections
%% --------------------------------
begin_phase_style_table(fid, 'Projection Accuracy by Phase: Rising, Peak, and Falling');

% ===================== AB 3-2 =====================
print_phase_style_group(fid, 'AB 3-2', ...
    {'One week'}, ...
    [ ...
        BTT(2).biasp_rising(1),  BTT(2).biasp_peak(1),  BTT(2).biasp_falling(1) ...
    ] * 100, ...
    [ ...
        BTT(2).rmsep_rising(1),  BTT(2).rmsep_peak(1),  BTT(2).rmsep_falling(1) ...
    ] * 100, ...
    [ ...
        BTT(2).sig_biasp_rising(1), BTT(2).sig_biasp_peak(1), BTT(2).sig_biasp_falling(1) ...
    ], ...
    [ ...
        BTT(2).phase_num(1,1), BTT(2).phase_num(2,1), BTT(2).phase_num(3,1) ...
    ]);

% ===================== AB 3-3 =====================
print_phase_style_group(fid, 'AB 3-3', ...
    {'One week','Two weeks','Four weeks'}, ...
    [ ...
        BTT(1).biasp_rising(1),  BTT(1).biasp_peak(1),  BTT(1).biasp_falling(1); ...
        BTT(1).biasp_rising(8),  BTT(1).biasp_peak(8),  BTT(1).biasp_falling(8); ...
        BTT(1).biasp_rising(22), BTT(1).biasp_peak(22), BTT(1).biasp_falling(22) ...
    ] * 100, ...
    [ ...
        BTT(1).rmsep_rising(1),  BTT(1).rmsep_peak(1),  BTT(1).rmsep_falling(1); ...
        BTT(1).rmsep_rising(8),  BTT(1).rmsep_peak(8),  BTT(1).rmsep_falling(8); ...
        BTT(1).rmsep_rising(22), BTT(1).rmsep_peak(22), BTT(1).rmsep_falling(22) ...
    ] * 100, ...
    [ ...
        BTT(1).sig_biasp_rising(1),  BTT(1).sig_biasp_peak(1),  BTT(1).sig_biasp_falling(1); ...
        BTT(1).sig_biasp_rising(8),  BTT(1).sig_biasp_peak(8),  BTT(1).sig_biasp_falling(8); ...
        BTT(1).sig_biasp_rising(22), BTT(1).sig_biasp_peak(22), BTT(1).sig_biasp_falling(22) ...
    ], ...
    [ ...
        BTT(1).phase_num(1,1),  BTT(1).phase_num(2,1),  BTT(1).phase_num(3,1); ...
        BTT(1).phase_num(1,8),  BTT(1).phase_num(2,8),  BTT(1).phase_num(3,8); ...
        BTT(1).phase_num(1,22), BTT(1).phase_num(2,22), BTT(1).phase_num(3,22) ...
    ]);

% ===================== Fujii-Nakata =====================
print_phase_style_group(fid, 'Fujii-Nakata', ...
    {'One week','Two weeks','Four weeks'}, ...
    [ ...
        BTT(3).biasp_rising(1), BTT(3).biasp_peak(1), BTT(3).biasp_falling(1); ...
        BTT(3).biasp_rising(2), BTT(3).biasp_peak(2), BTT(3).biasp_falling(2); ...
        BTT(3).biasp_rising(4), BTT(3).biasp_peak(4), BTT(3).biasp_falling(4) ...
    ] * 100, ...
    [ ...
        BTT(3).rmsep_rising(1), BTT(3).rmsep_peak(1), BTT(3).rmsep_falling(1); ...
        BTT(3).rmsep_rising(2), BTT(3).rmsep_peak(2), BTT(3).rmsep_falling(2); ...
        BTT(3).rmsep_rising(4), BTT(3).rmsep_peak(4), BTT(3).rmsep_falling(4) ...
    ] * 100, ...
    [ ...
        BTT(3).sig_biasp_rising(1), BTT(3).sig_biasp_peak(1), BTT(3).sig_biasp_falling(1); ...
        BTT(3).sig_biasp_rising(2), BTT(3).sig_biasp_peak(2), BTT(3).sig_biasp_falling(2); ...
        BTT(3).sig_biasp_rising(4), BTT(3).sig_biasp_peak(4), BTT(3).sig_biasp_falling(4) ...
    ], ...
    [ ...
        BTT(3).phase_num(1,1), BTT(3).phase_num(2,1), BTT(3).phase_num(3,1); ...
        BTT(3).phase_num(1,2), BTT(3).phase_num(2,2), BTT(3).phase_num(3,2); ...
        BTT(3).phase_num(1,4), BTT(3).phase_num(2,4), BTT(3).phase_num(3,4) ...
    ]);

% ===================== Hirata =====================
print_phase_style_group(fid, 'Hirata', ...
    {'One week','Two weeks','Four weeks'}, ...
    [ ...
        BTT(4).biasp_rising(7),  BTT(4).biasp_peak(7),  BTT(4).biasp_falling(7); ...
        BTT(4).biasp_rising(14), BTT(4).biasp_peak(14), BTT(4).biasp_falling(14); ...
        BTT(4).biasp_rising(28), BTT(4).biasp_peak(28), BTT(4).biasp_falling(28) ...
    ] * 100, ...
    [ ...
        BTT(4).rmsep_rising(7),  BTT(4).rmsep_peak(7),  BTT(4).rmsep_falling(7); ...
        BTT(4).rmsep_rising(14), BTT(4).rmsep_peak(14), BTT(4).rmsep_falling(14); ...
        BTT(4).rmsep_rising(28), BTT(4).rmsep_peak(28), BTT(4).rmsep_falling(28) ...
    ] * 100, ...
    [ ...
        BTT(4).sig_biasp_rising(7),  BTT(4).sig_biasp_peak(7),  BTT(4).sig_biasp_falling(7); ...
        BTT(4).sig_biasp_rising(14), BTT(4).sig_biasp_peak(14), BTT(4).sig_biasp_falling(14); ...
        BTT(4).sig_biasp_rising(28), BTT(4).sig_biasp_peak(28), BTT(4).sig_biasp_falling(28) ...
    ], ...
    [ ...
        BTT(4).phase_num(1,7),  BTT(4).phase_num(2,7),  BTT(4).phase_num(3,7); ...
        BTT(4).phase_num(1,14), BTT(4).phase_num(2,14), BTT(4).phase_num(3,14); ...
        BTT(4).phase_num(1,28), BTT(4).phase_num(2,28), BTT(4).phase_num(3,28) ...
    ]);

% ===================== CATs =====================
print_phase_style_group(fid, 'CATs', ...
    {'One week','Two weeks'}, ...
    [ ...
        BTT(5).biasp_rising(7),  BTT(5).biasp_peak(7),  BTT(5).biasp_falling(7); ...
        BTT(5).biasp_rising(14), BTT(5).biasp_peak(14), BTT(5).biasp_falling(14) ...
    ] * 100, ...
    [ ...
        BTT(5).rmsep_rising(7),  BTT(5).rmsep_peak(7),  BTT(5).rmsep_falling(7); ...
        BTT(5).rmsep_rising(14), BTT(5).rmsep_peak(14), BTT(5).rmsep_falling(14) ...
    ] * 100, ...
    [ ...
        BTT(5).sig_biasp_rising(7),  BTT(5).sig_biasp_peak(7),  BTT(5).sig_biasp_falling(7); ...
        BTT(5).sig_biasp_rising(14), BTT(5).sig_biasp_peak(14), BTT(5).sig_biasp_falling(14) ...
    ], ...
    [ ...
        BTT(5).phase_num(1,7),  BTT(5).phase_num(2,7),  BTT(5).phase_num(3,7); ...
        BTT(5).phase_num(1,14), BTT(5).phase_num(2,14), BTT(5).phase_num(3,14) ...
    ]);

end_phase_style_table(fid);

%% --------------------------------
%% Projection-specific phase summary tables
%% --------------------------------

% ===================== AB 3-2 =====================
begin_table_simple(fid, 'AB 3-2 projection accuracy by phase (peak phase = peak \pm 10 days)', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

print_group_rows_valid(fid, 'Rising', ...
    {'One week'}, ...
    BTT(2).rmsep_rising(1) * 100, ...
    BTT(2).biasp_rising(1) * 100, ...
    BTT(2).sig_biasp_rising(1), ...
    BTT(2).phase_num(1,1));

print_group_rows_valid(fid, 'Peak', ...
    {'One week'}, ...
    BTT(2).rmsep_peak(1) * 100, ...
    BTT(2).biasp_peak(1) * 100, ...
    BTT(2).sig_biasp_peak(1), ...
    BTT(2).phase_num(2,1));

print_group_rows_valid(fid, 'Falling', ...
    {'One week'}, ...
    BTT(2).rmsep_falling(1) * 100, ...
    BTT(2).biasp_falling(1) * 100, ...
    BTT(2).sig_biasp_falling(1), ...
    BTT(2).phase_num(3,1));

add_sig_note_compact(fid, 4);
end_table_simple(fid);

% ===================== AB 3-3 =====================
begin_table_simple(fid, 'AB 3-3 projection accuracy by phase (peak phase = peak \pm 10 days)', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

print_group_rows_valid(fid, 'Rising', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(1).rmsep_rising(1),  BTT(1).rmsep_rising(8),  BTT(1).rmsep_rising(22)] * 100, ...
    [BTT(1).biasp_rising(1),  BTT(1).biasp_rising(8),  BTT(1).biasp_rising(22)] * 100, ...
    [BTT(1).sig_biasp_rising(1),  BTT(1).sig_biasp_rising(8),  BTT(1).sig_biasp_rising(22)], ...
    [BTT(1).phase_num(1,1),  BTT(1).phase_num(1,8),  BTT(1).phase_num(1,22)]);

print_group_rows_valid(fid, 'Peak', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(1).rmsep_peak(1),  BTT(1).rmsep_peak(8),  BTT(1).rmsep_peak(22)] * 100, ...
    [BTT(1).biasp_peak(1),  BTT(1).biasp_peak(8),  BTT(1).biasp_peak(22)] * 100, ...
    [BTT(1).sig_biasp_peak(1),  BTT(1).sig_biasp_peak(8),  BTT(1).sig_biasp_peak(22)], ...
    [BTT(1).phase_num(2,1),  BTT(1).phase_num(2,8),  BTT(1).phase_num(2,22)]);

print_group_rows_valid(fid, 'Falling', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(1).rmsep_falling(1),  BTT(1).rmsep_falling(8),  BTT(1).rmsep_falling(22)] * 100, ...
    [BTT(1).biasp_falling(1),  BTT(1).biasp_falling(8),  BTT(1).biasp_falling(22)] * 100, ...
    [BTT(1).sig_biasp_falling(1),  BTT(1).sig_biasp_falling(8),  BTT(1).sig_biasp_falling(22)], ...
    [BTT(1).phase_num(3,1),  BTT(1).phase_num(3,8),  BTT(1).phase_num(3,22)]);

add_sig_note_compact(fid, 4);
end_table_simple(fid);

% ===================== Fujii-Nakata =====================
begin_table_simple(fid, 'Fujii-Nakata projection accuracy by phase (peak phase = peak \pm 10 days)', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

print_group_rows_valid(fid, 'Rising', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(3).rmsep_rising(1), BTT(3).rmsep_rising(2), BTT(3).rmsep_rising(4)] * 100, ...
    [BTT(3).biasp_rising(1), BTT(3).biasp_rising(2), BTT(3).biasp_rising(4)] * 100, ...
    [BTT(3).sig_biasp_rising(1), BTT(3).sig_biasp_rising(2), BTT(3).sig_biasp_rising(4)], ...
    [BTT(3).phase_num(1,1), BTT(3).phase_num(1,2), BTT(3).phase_num(1,4)]);

print_group_rows_valid(fid, 'Peak', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(3).rmsep_peak(1), BTT(3).rmsep_peak(2), BTT(3).rmsep_peak(4)] * 100, ...
    [BTT(3).biasp_peak(1), BTT(3).biasp_peak(2), BTT(3).biasp_peak(4)] * 100, ...
    [BTT(3).sig_biasp_peak(1), BTT(3).sig_biasp_peak(2), BTT(3).sig_biasp_peak(4)], ...
    [BTT(3).phase_num(2,1), BTT(3).phase_num(2,2), BTT(3).phase_num(2,4)]);

print_group_rows_valid(fid, 'Falling', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(3).rmsep_falling(1), BTT(3).rmsep_falling(2), BTT(3).rmsep_falling(4)] * 100, ...
    [BTT(3).biasp_falling(1), BTT(3).biasp_falling(2), BTT(3).biasp_falling(4)] * 100, ...
    [BTT(3).sig_biasp_falling(1), BTT(3).sig_biasp_falling(2), BTT(3).sig_biasp_falling(4)], ...
    [BTT(3).phase_num(3,1), BTT(3).phase_num(3,2), BTT(3).phase_num(3,4)]);

add_sig_note_compact(fid, 4);
end_table_simple(fid);

% ===================== Hirata =====================
begin_table_simple(fid, 'Hirata projection accuracy by phase (peak phase = peak \pm 10 days)', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

print_group_rows_valid(fid, 'Rising', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(4).rmsep_rising(7), BTT(4).rmsep_rising(14), BTT(4).rmsep_rising(28)] * 100, ...
    [BTT(4).biasp_rising(7), BTT(4).biasp_rising(14), BTT(4).biasp_rising(28)] * 100, ...
    [BTT(4).sig_biasp_rising(7), BTT(4).sig_biasp_rising(14), BTT(4).sig_biasp_rising(28)], ...
    [BTT(4).phase_num(1,7), BTT(4).phase_num(1,14), BTT(4).phase_num(1,28)]);

print_group_rows_valid(fid, 'Peak', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(4).rmsep_peak(7), BTT(4).rmsep_peak(14), BTT(4).rmsep_peak(28)] * 100, ...
    [BTT(4).biasp_peak(7), BTT(4).biasp_peak(14), BTT(4).biasp_peak(28)] * 100, ...
    [BTT(4).sig_biasp_peak(7), BTT(4).sig_biasp_peak(14), BTT(4).sig_biasp_peak(28)], ...
    [BTT(4).phase_num(2,7), BTT(4).phase_num(2,14), BTT(4).phase_num(2,28)]);

print_group_rows_valid(fid, 'Falling', ...
    {'One week','Two weeks','Four weeks'}, ...
    [BTT(4).rmsep_falling(7), BTT(4).rmsep_falling(14), BTT(4).rmsep_falling(28)] * 100, ...
    [BTT(4).biasp_falling(7), BTT(4).biasp_falling(14), BTT(4).biasp_falling(28)] * 100, ...
    [BTT(4).sig_biasp_falling(7), BTT(4).sig_biasp_falling(14), BTT(4).sig_biasp_falling(28)], ...
    [BTT(4).phase_num(3,7), BTT(4).phase_num(3,14), BTT(4).phase_num(3,28)]);

add_sig_note_compact(fid, 4);
end_table_simple(fid);

% ===================== CATs =====================
begin_table_simple(fid, 'CATs projection accuracy by phase (peak phase = peak \pm 10 days)', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

print_group_rows_valid(fid, 'Rising', ...
    {'One week','Two weeks'}, ...
    [BTT(5).rmsep_rising(7), BTT(5).rmsep_rising(14)] * 100, ...
    [BTT(5).biasp_rising(7), BTT(5).biasp_rising(14)] * 100, ...
    [BTT(5).sig_biasp_rising(7), BTT(5).sig_biasp_rising(14)], ...
    [BTT(5).phase_num(1,7), BTT(5).phase_num(1,14)]);

print_group_rows_valid(fid, 'Peak', ...
    {'One week','Two weeks'}, ...
    [BTT(5).rmsep_peak(7), BTT(5).rmsep_peak(14)] * 100, ...
    [BTT(5).biasp_peak(7), BTT(5).biasp_peak(14)] * 100, ...
    [BTT(5).sig_biasp_peak(7), BTT(5).sig_biasp_peak(14)], ...
    [BTT(5).phase_num(2,7), BTT(5).phase_num(2,14)]);

print_group_rows_valid(fid, 'Falling', ...
    {'One week','Two weeks'}, ...
    [BTT(5).rmsep_falling(7), BTT(5).rmsep_falling(14)] * 100, ...
    [BTT(5).biasp_falling(7), BTT(5).biasp_falling(14)] * 100, ...
    [BTT(5).sig_biasp_falling(7), BTT(5).sig_biasp_falling(14)], ...
    [BTT(5).phase_num(3,7), BTT(5).phase_num(3,14)]);

add_sig_note_compact(fid, 4);
end_table_simple(fid);

%% --------------------------------
%% Weighted average phase summary across projections
%% --------------------------------
begin_table_simple(fid, 'Weighted average projection accuracy by phase (peak phase = peak \pm 10 days) across projections', 'lD{.}{.}{-1}D{.}{.}{-1}c');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{N} \\\\');
fprintf(fid,'\n \\hline');

phase_group_titles = {'Rising','Peak','Falling'};

for pp = 1:3
    w_biasp_phase = NaN(1,3);
    w_rmsep_phase = NaN(1,3);
    w_N_phase     = NaN(1,3);
    w_sig_phase   = strings(1,3);

    for hh = 1:3
        vec = collect_errorp_phase(BTT, HMAP(hh,:), phase_names(pp));
        [w_biasp_phase(hh), w_rmsep_phase(hh), w_N_phase(hh), w_sig_phase(hh)] = pooled_metrics_from_errorp(vec);
    end

    print_group_rows_valid(fid, phase_group_titles{pp}, ...
        horizon_labels_common, ...
        w_rmsep_phase * 100, ...
        w_biasp_phase * 100, ...
        w_sig_phase, ...
        w_N_phase);
end

add_sig_note_compact(fid, 4);
end_table_simple(fid);

fclose(fid);


function [lb90, ub90, lb95, ub95, lb99, ub99, sig] = make_ci_and_sig(mean_vec, sem_vec, df_vec)

    if nargin < 3 || isempty(df_vec)
        % Normal critical values
        crit90 = 1.64485362695147;
        crit95 = 1.95996398454005;
        crit99 = 2.57582930354890;

        lb90 = mean_vec - crit90 .* sem_vec;
        ub90 = mean_vec + crit90 .* sem_vec;

        lb95 = mean_vec - crit95 .* sem_vec;
        ub95 = mean_vec + crit95 .* sem_vec;

        lb99 = mean_vec - crit99 .* sem_vec;
        ub99 = mean_vec + crit99 .* sem_vec;
    else
        % t critical values with df = N-1 (element-wise)
        df_vec = double(df_vec);

        % Initialize with NaNs
        crit90 = NaN(size(df_vec));
        crit95 = NaN(size(df_vec));
        crit99 = NaN(size(df_vec));

        ok = (df_vec > 0);

        % Two-sided CI: 90% -> 0.95, 95% -> 0.975, 99% -> 0.995
        try
            crit90(ok) = tinv(0.95,  df_vec(ok));
            crit95(ok) = tinv(0.975, df_vec(ok));
            crit99(ok) = tinv(0.995, df_vec(ok));
        catch
            % Fallbacks (in case tinv is unavailable)
            try
                crit90(ok) = icdf('t', 0.95,  df_vec(ok));
                crit95(ok) = icdf('t', 0.975, df_vec(ok));
                crit99(ok) = icdf('t', 0.995, df_vec(ok));
            catch
                % Last-resort: normal approximation
                z90 = 1.64485362695147;
                z95 = 1.95996398454005;
                z99 = 2.57582930354890;
                crit90(ok) = z90;
                crit95(ok) = z95;
                crit99(ok) = z99;
            end
        end

        lb90 = mean_vec - crit90 .* sem_vec;
        ub90 = mean_vec + crit90 .* sem_vec;

        lb95 = mean_vec - crit95 .* sem_vec;
        ub95 = mean_vec + crit95 .* sem_vec;

        lb99 = mean_vec - crit99 .* sem_vec;
        ub99 = mean_vec + crit99 .* sem_vec;
    end

    sig = strings(size(mean_vec));

    % Only assign stars where SEM is valid and intervals are defined
    good = ~isnan(mean_vec) & ~isnan(sem_vec) & (sem_vec > 0);
    if nargin >= 3 && ~isempty(df_vec)
        good = good & (df_vec > 0);
    end

    sig(good & (lb90 .* ub90 > 0)) = "*";
    sig(good & (lb95 .* ub95 > 0)) = "**";
    sig(good & (lb99 .* ub99 > 0)) = "***";
end


% ---------- helper functions ----------
function begin_table_simple(fid, caption_txt, colspec)
fprintf(fid,'\n \\begin{table}');
fprintf(fid,'\n \\begin{center}');
fprintf(fid,'\n \\caption{%s}', caption_txt);
fprintf(fid,'\n \\begin{tabular}{%s}', colspec);
end

function end_table_simple(fid)
fprintf(fid,'\n \\end{tabular}');
fprintf(fid,'\n \\end{center}');
fprintf(fid,'\n \\end{table}');
end

function add_sig_note_compact(fid, ncol)
fprintf(fid,'\n \\hline');
fprintf(fid,'\n \\multicolumn{%d}{l}{\\footnotesize Bias(\\%%): *** p$<$0.01, ** p$<$0.05, * p$<$0.10.} \\\\', ncol);
end

function print_group_rows(fid, group_title, horizon_labels, rmsep_vec, biasp_vec, sig_vec, n_vec)
fprintf(fid,'\n \\multicolumn{4}{c}{%s} \\\\', group_title);
fprintf(fid,'\n \\hline');
for ii = 1:numel(horizon_labels)
    print_compact_row(fid, horizon_labels{ii}, rmsep_vec(ii), biasp_vec(ii), sig_vec(ii), n_vec(ii));
end
fprintf(fid,'\n \\hline');
end

function print_compact_row(fid, label_txt, rmsep_val, biasp_val, sig_val, n_val)
fprintf(fid,'\n %s & %.1f%s & %.1f & %0.0f \\\\', ...
    label_txt, biasp_val, sig_suffix(sig_val), rmsep_val, n_val);
end

function s = sig_suffix(sig_code)
if isstring(sig_code)
    sig_code = char(sig_code);
end

if ischar(sig_code)
    if strcmp(sig_code, '***')
        s = '^{***}';
    elseif strcmp(sig_code, '**')
        s = '^{**}';
    elseif strcmp(sig_code, '*')
        s = '^{*}';
    else
        s = '';
    end
else
    s = '';
end
end

function vec = collect_errorp_all(BTT, idx_by_model)
vec = [];
for m = 1:numel(idx_by_model)
    idx = idx_by_model(m);
    if ~isnan(idx) && idx <= size(BTT(m).TT.errorp, 2)
        tmp = BTT(m).TT.errorp(:, idx);
        vec = [vec; tmp(~isnan(tmp))];
    end
end
end

function vec = collect_errorp_phase(BTT, idx_by_model, phase_name)
vec = [];
for m = 1:numel(idx_by_model)
    idx = idx_by_model(m);
    if ~isnan(idx) && idx <= size(BTT(m).TT.errorp, 2)
        TTm = BTT(m).TT(BTT(m).TT.phase == phase_name, :);
        tmp = TTm.errorp(:, idx);
        vec = [vec; tmp(~isnan(tmp))];
    end
end
end

function vec = collect_errorp_wave(BTT, idx_by_model, wave_id)
vec = [];
for m = 1:numel(idx_by_model)
    idx = idx_by_model(m);
    if ~isnan(idx) && idx <= size(BTT(m).TT.errorp, 2)
        TTm = BTT(m).TT(BTT(m).TT.wave == wave_id, :);
        tmp = TTm.errorp(:, idx);
        vec = [vec; tmp(~isnan(tmp))];
    end
end
end

function [biasp, rmsep, N, sig] = pooled_metrics_from_errorp(vec)
vec = vec(~isnan(vec));
N = numel(vec);

if N == 0
    biasp = NaN;
    rmsep = NaN;
    sig   = "";
    return;
end

biasp = mean(vec);
rmsep = sqrt(mean(vec.^2));

if N > 1
    sd  = sqrt(sum((vec - biasp).^2) / (N-1));
    sem = sd / sqrt(N);
else
    sd  = NaN;
    sem = NaN;
end

[~,~,~,~,~,~,sig] = make_ci_and_sig(biasp, sem, N-1);
end

function print_group_rows_valid(fid, group_title, horizon_labels, rmsep_vec, biasp_vec, sig_vec, n_vec)
fprintf(fid,'\n \\multicolumn{4}{c}{%s} \\\\', group_title);
fprintf(fid,'\n \\hline');
for ii = 1:numel(horizon_labels)
    if ~isnan(n_vec(ii)) && n_vec(ii) > 0
        print_compact_row(fid, horizon_labels{ii}, rmsep_vec(ii), biasp_vec(ii), sig_vec(ii), n_vec(ii));
    end
end
fprintf(fid,'\n \\hline');
end

function begin_phase_style_table(fid, caption_txt)
fprintf(fid,'\n \\begin{table}');
fprintf(fid,'\n \\begin{center}');
fprintf(fid,'\n \\caption{%s}', caption_txt);
fprintf(fid,'\n \\begin{tabular}{lD{.}{.}{-1}D{.}{.}{-1}D{.}{.}{-1}D{.}{.}{-1}D{.}{.}{-1}D{.}{.}{-1}}');
fprintf(fid,'\n \\hline');
fprintf(fid,'\n Phase & \\multicolumn{1}{c}{Rising} & \\multicolumn{1}{c}{Peak} & \\multicolumn{1}{c}{Falling} & \\multicolumn{1}{c}{Rising} & \\multicolumn{1}{c}{Peak} & \\multicolumn{1}{c}{Falling} \\\\');
fprintf(fid,'\n Projection horizon & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{Bias(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} & \\multicolumn{1}{c}{RMSE(\\%%)} \\\\');
fprintf(fid,'\n \\hline');
end

function print_phase_style_group(fid, group_title, horizon_labels, biasp_mat, rmsep_mat, sig_mat, n_mat)
fprintf(fid,'\n \\multicolumn{7}{c}{%s} \\\\', group_title);
fprintf(fid,'\n \\hline');

for ii = 1:numel(horizon_labels)
    print_phase_style_row(fid, horizon_labels{ii}, biasp_mat(ii,:), rmsep_mat(ii,:), sig_mat(ii,:), n_mat(ii,:));
end

fprintf(fid,'\n \\hline');
end

function print_phase_style_row(fid, label_txt, biasp_row, rmsep_row, sig_row, n_row)
fprintf(fid,'\n %s & %.1f%s & %.1f%s & %.1f%s & %.1f & %.1f & %.1f \\\\', ...
    label_txt, ...
    biasp_row(1), sig_suffix(sig_row(1)), ...
    biasp_row(2), sig_suffix(sig_row(2)), ...
    biasp_row(3), sig_suffix(sig_row(3)), ...
    rmsep_row(1), rmsep_row(2), rmsep_row(3));

fprintf(fid,['\n  & \\multicolumn{1}{c}{(N=%0.0f)} & \\multicolumn{1}{c}{(N=%0.0f)} ' ...
             '& \\multicolumn{1}{c}{(N=%0.0f)} & \\multicolumn{1}{c}{(N=%0.0f)} ' ...
             '& \\multicolumn{1}{c}{(N=%0.0f)} & \\multicolumn{1}{c}{(N=%0.0f)} \\\\'], ...
    n_row(1), n_row(2), n_row(3), n_row(1), n_row(2), n_row(3));
end

function end_phase_style_table(fid)
fprintf(fid,'\n \\multicolumn{7}{l}{\\footnotesize Bias(\\%%): *** p$<$0.01, ** p$<$0.05, * p$<$0.10.} \\\\');
fprintf(fid,'\n \\end{tabular}');
fprintf(fid,'\n \\end{center}');
fprintf(fid,'\n \\end{table}');
end
