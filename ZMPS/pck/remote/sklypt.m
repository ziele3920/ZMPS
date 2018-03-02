close all; clc; clear;

filesDirectoryName = 'database';
resultDirName = 'pictures';

if(exist(resultDirName, 'dir') == 0)
    mkdir(resultDirName)
end

files = dir(fullfile(filesDirectoryName, '*.csv'));
fileNames = {files.name}';
filesCount = length(files);
parametersCount = 6;
Results = NaN(filesCount, parametersCount + 2);
exceptions = cell(filesCount, 1);

for k = 1 : filesCount
    try
        fileId = fopen(fullfile(filesDirectoryName, fileNames{k}), 'r');
        data = textscan(fileId, '', 'HeaderLines', 1, 'Delimiter', {',' , ';'}, 'CollectOutput', true);
        fclose(fileId);
        data = data{1};

        abp = data(:,4);
        rr = data(:,9);

        fileNameShort = fileNames{k}(1:end-4);
        subplot(211); plot(abp), ylabel('ABP [mmHg]');
        subplot(212); plot(rr); ylabel('RR [breath/min]');
        title(fileNameShort, 'Interpreter','none');
        print([resultDirName filesep fileNameShort], '-dpng');

        %calculations
        Results(k, 1) = nanmean(abp);
        Results(k, 2) = nanmedian(abp);
        Results(k, 3) = nanstd(abp);
        Results(k, 4) = nanmean(rr);
        Results(k, 5) = nanmedian(rr);
        Results(k, 6) = nanstd(rr);
        Results(k, 7) = sum(isnan(abp))/length(abp);
        Results(k, 8) = sum(isnan(rr))/length(rr);
        disp(k)
    catch exc
        disp(['Error occured k = ' num2str(k) ', file name ' fileNames{k}]);
        exceptions{k} = exc;
    end
end

header = {'fileName', 'meanAbp', 'medianABP', 'stdABP', 'meanRR', 'medianRR', 'stdRR', 'nanABPpercentage', 'nanRRpercentage'};
xlsResults = [header; fileNames num2cell(Results)];
xlswrite('results', xlsResults);