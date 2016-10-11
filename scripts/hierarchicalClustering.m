function hierarchicalClustering(expression, samples, features, varargin)

% Plots clustergram for the expression data
% Inputs:
%   expression  Expression data, n-by-p, n samples, p features 
%   samples     Sample Annotation, n-by-1 cell vector
%   features    Feature Annotation, p-by-1 cell vector
%   varargin 1  Threshold to filter expression data (exclusive)
%            2  Title plot
%            3  Save figure?: 'true' 'false' outputDir

plotTitle = 'Hierarchical Clustering';
saveFigure = 'true';

if numel(varargin)==3
    %threshold
    threshold = varargin{1};
    ind = min(expression)>threshold;
    expression = expression(:,ind);
    features = features(ind,:); 
    %Title Plot
    plotTitle = varargin(2);
    %Save figure
    saveFigure = varargin(3);
end

% Plot hierarchical clustering
% Standardising along the rows (features) before hierarchical clustering
% as expression transposed is p-by-n 
hc = clustergram(expression',...
    'ColumnLabels',samples,...    
    'Standardize',2,'Colormap','redbluecmap', ...
    'OptimalLeafOrder', true);
set(hc,'RowLabels',features)
addTitle(hc, plotTitle)
plot(hc)

if ~strcmp(saveFigure,'false')
    if strcmp(saveFigure, 'true')
        outputDir = 'output_MultiPEN/stats/';
    else
        outputDir = saveResults;
    end

    %check if output directory exists
    if exist(outputDir, 'dir') ~= 7
        mkdir(outputDir)
    end

    % Statistics for cross validation
    fileName = [outputDir 'hierarchicalClustering.png'];
    saveas(gcf, fileName)
    fprintf('\tFigure save to file: \n\t%s\n', ...
        fileName)
                        
end

close all
clear hc %close clustergram