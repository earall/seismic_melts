function plot_tensor(velocity,sample_name, path)
% plot_tensor.m - A. L. Lee
% Plot the 3D tensors visualised for seismic properties
% 
%   This function gives produces 6 tensor plots for the seismic properties
%   calculated in the calc_velocity.m function.
%
%   INPUT
%   velocity - as calculate by calc_velocity.m function when 'All' is
%   specified
%   sample_name - Sample ID, may wish to specify model type here
%   path - file path to save output plot, if saving in current directory
%   use ''
%   
%   OUTPUT
%   PDF file with plots for the 6 seismic properties; vp, vs1, vs2, avs,
%   vp/vs1 and vp/vs2
%
%   Please direct all questions to A. L. Lee
%
%   
%% ***********************************************************************
%
% Set MTEX plotting preferences
setMTEXpref('zAxisDirection','north');
setMTEXpref('yAxisDirection','outofplane');
setMTEXpref('defaultColorMap',flipud(jet));
set(0,'DefaultFigureVisible','on')
titleOpt = {'visible','on','color','k'};

% Max/min markers
Marker_size_max_min = 10;
blackMarker = {'Marker','s','MarkerSize',5,'antipodal',...
  'MarkerEdgeColor','white','MarkerFaceColor','black','doNotDraw'};
whiteMarker = {'Marker','o','MarkerSize',5,'antipodal',...
  'MarkerEdgeColor','black','MarkerFaceColor','white','doNotDraw'};
plota2east;

% Header labels
seismics_name = {'Vp (km/s)', 'Vs1 (km/s)', 'Vs2 (km/s)',...
    'AVs (%)', 'Vp/Vs1','Vp/Vs2'};

mtexFig = mtexFigure('position',[0 0 300 2000]);

mtexFig.ncols  = 6;
mtexFig.nrows  = 1;
%%
for i = 1:6
    mtexFig.ncols  = 6;
    mtexFig.nrows  = 1;

        % Plot seismic property
        plot(velocity{i},'contourf','complete','lower');
        mtexTitle(seismics_name{i},titleOpt{:})
        
        % Plot polarising vectors for vs1 and vs2
        if i == 2 || i == 3
            hold on
            plot(velocity{i+5},'linewidth',2,'color','black','doNotDraw')
            hold off
        end
        
        % extrema
        [maxV, maxVPos] = max(velocity{i});
        [minV, minVPos] = min(velocity{i});
        
        % mark maximum with black square and minimum with white circle
        hold on
        plot(maxVPos,blackMarker{:})
        plot(minVPos,whiteMarker{:})
        hold off
      
        % subTitle
        Max = ['Max = ',num2str(maxV,'%6.2f')];
        Min = ['Min = ',num2str(minV,'%6.2f')];
        xlabel({Max,Min},titleOpt{:})
        
        % mark crystal axes
        annotate([xvector,yvector,zvector],'label',{'X','Z','Y'},...
            'FontSize',18,'BackgroundColor','w');
        
        % set axis limits
        if i == 1
            caxis([0,7])
        elseif i == 2 || i == 3
            caxis([0,7])
        elseif i == 4
            caxis([0,200])
        else
            caxis([0,10])
        end
        
    % next axis
    if i == 6
    else
        mtexFig.nextAxis
    end
        


end
    
% add a colourbar
mtexColorbar

% sample ID
text('FontWeight','bold','FontSize',20,'String',sample_name,...
 'Position',[-22.2 -1.4 0],'Visible','on');

% save path
figure_name = [path, 'Voigt_Seismics_',sample_name,'.pdf'];

% file save specifications
g=gcf;
set(g,'PaperOrientation','landscape');
% set(g,'PaperSize',[75 12]);
set(g,'Renderer','painters');

print('-dpdf', '-fillpage',figure_name)

% End of function
end
