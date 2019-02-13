function graph_seismics(Xvar, Yvar, method, plot_name)

set(gcf,'visible','off')
set(figure, 'Position', [0 0 1200 600])
set(gcf,'Color',[1,1,1])
set(gca,'Color','None')

if length(Yvar) == 7
    line_colour_stlye = ...
    {{'color',[0.3019,0.3019,0.3019],'LineWidth',1.5}...
    {'color',[0.9290,0.6940,0.1250],'LineWidth',1.5,'LineStyle','--'}...
    {'color',[0.9290,0.6940,0.1250],'LineWidth',1.5,'LineStyle',':'}...
    {'color',[0.4940,0.1840,0.5560],'LineWidth',1.5,'LineStyle','--'}...
    {'color',[0.4940,0.1840,0.5560],'LineWidth',1.5,'LineStyle',':'}...
    {'color',[0.0000,0.4470,0.7410],'LineWidth',1.5,'LineStyle','--'}...
    {'color',[0.0000,0.6000,0.2000],'LineWidth',1.5,'LineStyle','--'}};
elseif length(Yvar) == 3
    line_colour_stlye = ...
    {{'color',[0, 0.4470, 0.7410],'LineWidth',1.5}...
    {'color',[0.4940, 0.1840, 0.5560]	,'LineWidth',1.5}...
    {'color',[0.4660, 0.6740, 0.1880]	,'LineWidth',1.5}};
end
    

%% ************************************************************************
if strcmp(method, 'Model')
    melt = Xvar;
    seismics = Yvar;
    
    for i = 1:7
    
    s1 = subplot(2,3,1);   
    plot(melt,seismics{i}(:,2),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vp');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,40,0,9])
    
    %**********************************************************************
    
    s2 = subplot(2,3,2);
    plot(melt,seismics{i}(:,3),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vs1');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,40,0,8])
    
    %**********************************************************************
    
    s3 = subplot(2,3,3);
    plot(melt,seismics{i}(:,4),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vs2');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,8])
    
    %**********************************************************************
    
    s4 = subplot(2,3,4);
    plot(melt,seismics{i}(:,5),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('AVs');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Anisotropy (%)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,15])
    
    
    
    %**********************************************************************
    
    s5 = subplot(2,3,5);
    plot(melt,seismics{i}(:,6),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vp/Vs1');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vp/Vs');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,50])
    
    %**********************************************************************
    
    s6 = subplot(2,3,6);
    line{i} = plot(melt,seismics{i}(:,7),line_colour_stlye{i}{:});
    hold on
    
    hTitle = title('Vp/Vs2');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vp/Vs');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,50]);

    %**********************************************************************

end

set(s1,'position',[0.1300 0.6171 0.2134 0.3412]);
set(s2,'position',[0.4108 0.6171 0.2134 0.3412]);
set(s3,'position',[0.6913 0.6171 0.2134 0.3412]);
set(s4,'position',[0.1300 0.1533 0.2134 0.3412]);
set(s5,'position',[0.4108 0.1533 0.2134 0.3412]);
set(s6,'position',[0.6913 0.1533 0.2134 0.3412]);

hL = gridLegend(...
    [line{1},line{2},line{3},line{4},line{5},line{6},line{7}], 7,...
    {'Isotropic','Oblate (horizontal, < 1)','Oblate (vertical, < 1)',...
    'Prolate (horizontal, > 1)','Prolate (vertical, > 1)','Layered',...
    'Crystal Fabric'} ,...
    'location','south', 'Orientation','Horizontal');

set(hL,'Position',[0.02538 0.0203 0.9492 0.0505]);

export_fig(['Model_examples_',plot_name,'.pdf'])
%% ************************************************************************
elseif strcmp(method, 'Transect')
    distance = Xvar;
    seismics = Yvar;
    mD = 1.4;
    
    for i = 1:length(seismics)
    
    s1 = subplot(2,3,1);   
    plot(distance,seismics{i}(:,2),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vp');
    hXLabel = xlabel('Distance (km)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,mD,0,8.5])
    
    %**********************************************************************
    
    s2 = subplot(2,3,2);
    plot(distance,seismics{i}(:,3),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vs1');
    hXLabel = xlabel('Distance (km)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,mD,0,8.5])
    
    %**********************************************************************
    
    s3 = subplot(2,3,3);
    plot(distance,seismics{i}(:,4),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vs2');
    hXLabel = xlabel('Distance (km)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,mD,0,8.5])
    
    %**********************************************************************
    
    s4 = subplot(2,3,4);
    plot(distance,seismics{i}(:,5),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('AVs');
    hXLabel = xlabel('Distance (km)');
    hYLabel = ylabel('Anisotropy (%)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,mD,0,15])
    
    
    
    %**********************************************************************
    
    s5 = subplot(2,3,5);
    plot(distance,seismics{i}(:,6),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vp/Vs1');
    hXLabel = xlabel('Distance (km)');
    hYLabel = ylabel('Vp/Vs');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,mD,0,50])
    
    %**********************************************************************
    
    s6 = subplot(2,3,6);
    line{i} = plot(distance,seismics{i}(:,7),line_colour_stlye{i}{:});
    hold on
    
    hTitle = title('Vp/Vs2');
    hXLabel = xlabel('Distance (km)');
    hYLabel = ylabel('Vp/Vs');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,mD,0,50]);

    %**********************************************************************

    end



set(s1,'position',[0.1300 0.6171 0.2134 0.3412]);
set(s2,'position',[0.4108 0.6171 0.2134 0.3412]);
set(s3,'position',[0.6913 0.6171 0.2134 0.3412]);
set(s4,'position',[0.1300 0.1533 0.2134 0.3412]);
set(s5,'position',[0.4108 0.1533 0.2134 0.3412]);
set(s6,'position',[0.6913 0.1533 0.2134 0.3412]);

if length(seismics) == 7
   hL = gridLegend(...
        [line{1},line{2},line{3},line{4},line{5},line{6},line{7}], 7,...
        {'Isotropic','Oblate (horizontal, < 1)','Oblate (vertical, < 1)',...
        'Prolate (horizontal, > 1)','Prolate (vertical, > 1)','Layered',...
        'Crystal Fabric'} ,...
        'location','south', 'Orientation','Horizontal');

    set(hL,'Position',[0.02538 0.0203 0.9492 0.0505]);
else
end

export_fig(['Transect_',plot_name,'.pdf'])

%% ************************************************************************    
elseif strcmp(method,'Surface')
        melt = Xvar;
    seismics = Yvar;
    
    for i = 1:7
    
    s1 = subplot(2,3,1);   
    plot(melt,seismics{1}(:,i),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Love X');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,40,0,9])
    
    %**********************************************************************
    
    s2 = subplot(2,3,2);
    plot(melt,seismics{2}(:,i),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Love Y');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,40,0,8])
    
    %**********************************************************************
    
    s3 = subplot(2,3,3);
    plot(melt,seismics{3}(:,i),line_colour_stlye{i}{:})
    hold on
    plot(melt,seismics{4}(:,i),line_colour_stlye{i}{:})
    
    hTitle = title('Vs1');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,8])
    
    %**********************************************************************
    
    s4 = subplot(2,3,4);
    plot(melt,seismics{5}(:,i),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Rayleigh X');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,8])
    
    
    
    %**********************************************************************
    
    s5 = subplot(2,3,5);
    plot(melt,seismics{6}(:,i),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Rayleigh Y');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,8])
    
    %**********************************************************************
    
    s6 = subplot(2,3,6);
    line{i} = plot(melt,seismics{7}(:,i),line_colour_stlye{i}{:});
    hold on
    plot(melt,seismics{8}(:,i),line_colour_stlye{i}{:})
    
    hTitle = title('Vs2');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,40,0,8])

    %**********************************************************************

end

set(s1,'position',[0.1300 0.6171 0.2134 0.3412]);
set(s2,'position',[0.4108 0.6171 0.2134 0.3412]);
set(s3,'position',[0.6913 0.6171 0.2134 0.3412]);
set(s4,'position',[0.1300 0.1533 0.2134 0.3412]);
set(s5,'position',[0.4108 0.1533 0.2134 0.3412]);
set(s6,'position',[0.6913 0.1533 0.2134 0.3412]);

hL = gridLegend(...
    [line{1},line{2},line{3},line{4},line{5},line{6},line{7}], 7,...
    {'Isotropic','Oblate (horizontal, < 1)','Oblate (vertical, < 1)',...
    'Prolate (horizontal, > 1)','Prolate (vertical, > 1)','Layered',...
    'Crystal Fabric'} ,...
    'location','south', 'Orientation','Horizontal');

set(hL,'Position',[0.02538 0.0203 0.9492 0.0505]);

export_fig(['Model_examples_',plot_name,'.pdf'])

%% ************************************************************************    
elseif strcmp(method,'Surface All')
    melt = Xvar;
    VsVs0R = Yvar{1};
    VsVs0L = Yvar{2};
    
%%
for i = 1:7
    subplot(2,2,1)
    plot(melt,VsVs0L(:,i),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Love Waves');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vs/Vs^0');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,40,0,1])
    
    %**********************************************************************
    
    subplot(2,2,2)
    plot(melt,VsVs0R(:,i),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Rayleigh Waves');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vs/Vs^0');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,40,0,1])
    
    %**********************************************************************
    
    subplot(2,2,3)
    plot(melt,VsVs0L(:,i),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Love Waves');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vs/Vs^0');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,15,0.7,1])
    
    subplot(2,2,4);
    if i == 1
        line{i} = plot(0.1,0.1,'color','white');
        hold on
        line{i+1} = plot(melt,VsVs0R(:,i),line_colour_stlye{i}{:});
    elseif i == 10
        line{i+1} = plot(0.1,0.1,'color','white');
        hold on
        line{i+2} = plot(melt,VsVs0R(:,i),line_colour_stlye{i}{:});
    elseif i < 10
        line{i+1} = plot(melt,VsVs0R(:,i),line_colour_stlye{i}{:});
    elseif i > 10
        line{i+2} = plot(melt,VsVs0R(:,i),line_colour_stlye{i}{:});
    end
    
    hold on
    
    hTitle = title('Rayleigh Waves');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vs/Vs^0');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,15,0.7,1])
        
    %**********************************************************************
end

%if w == 7
    hLegend = legend('Isotropic','Oblate (horizontal, \alpha < 1)',...
        'Oblate (vertical, \alpha < 1)',...
        'Prolate (horizontal, \alpha > 1)',...
        'Prolate (vertical, \alpha > 1)','Layered','Crystal Fabric',...
            'location', 'Northeast');
    set(hLegend,'FontSize',10);
    set(hLegend,'Position',[0.7197 0.2372 0.1341 0.1788]);
    
    export_fig(['Velocity_ratio_',plot_name,'.pdf'])
    
%% ************************************************************************    
elseif strcmp(method,'Surface Shape')
    del = Xvar;
    VsVs0R = Yvar{1};
    VsVs0L = Yvar{2};
    
    set(gca, 'ColorOrder', jet);
    
for i = 1:length(del)
    subplot(2,1,1)
    semilogx(del,VsVs0R(:,i))
    hold on
    
    hTitle = title('Rayleigh Waves');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vs/Vs^0');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,10000,0,1])
    
    %**********************************************************************
    
    subplot(2,1,2)
    semilogx(del,VsVs0L(:,i))
    hold on
    
    hTitle = title('Love Waves');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vs/Vs^0');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,10000,0,1])
    
  
    %**********************************************************************
end
   
export_fig(['Velocity_ratio_shape_change_',plot_name,'.pdf'])

    
%% ************************************************************************
elseif strcmp(method,'Voigt Reuss')
    melt = Xvar;
    seismics = Yvar;
    
    
    line_colour_stlye = ...
    {{'color',[0.3019,0.3019,0.3019],'LineWidth',1.5}...
    {'color',[0.0000,0.6000,0.2000],'LineWidth',1.5}...
    {'color',[0.3019,0.3019,0.3019],'LineWidth',1.5,'LineStyle',':'}...
    {'color',[0.0000,0.6000,0.2000],'LineWidth',1.5,'LineStyle',':'}};

for i = 1:4
    
    s1 = subplot(2,3,1);   
    plot(melt,seismics{i}(:,2),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vp');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,100,0,8])
    
    %**********************************************************************
    
    s2 = subplot(2,3,2);
    plot(melt,seismics{i}(:,3),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vs1');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    axis([0,100,0,8])
    
    %**********************************************************************
    
    s3 = subplot(2,3,3);
    plot(melt,seismics{i}(:,4),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vs2');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Velocity (km/s)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,100,0,8])
    
    %**********************************************************************
    
    s4 = subplot(2,3,4);
    plot(melt,seismics{i}(:,5),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('AVs');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Anisotropy (%)');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,100,0,150])
    
    %**********************************************************************
    
    s5 = subplot(2,3,5);
    plot(melt,seismics{i}(:,6),line_colour_stlye{i}{:})
    hold on
    
    hTitle = title('Vp/Vs1');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vp/Vs');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,100,0,80])
    
    %**********************************************************************
    
    s6 = subplot(2,3,6);
    line{i} = plot(melt,seismics{i}(:,7),line_colour_stlye{i}{:});
    hold on
    
    hTitle = title('Vp/Vs2');
    hXLabel = xlabel('Melt Fraction (%)');
    hYLabel = ylabel('Vp/Vs');
    set([hXLabel, hYLabel],'FontSize',8);
    set(gca,'fontsize',8)
    set( hTitle,'FontSize',12,'FontWeight','bold');
    
    axis([0,100,0,80]);

    %**********************************************************************

end

set(s1,'position',[0.1300 0.6171 0.2134 0.3412]);
set(s2,'position',[0.4108 0.6171 0.2134 0.3412]);
set(s3,'position',[0.6913 0.6171 0.2134 0.3412]);
set(s4,'position',[0.1300 0.1533 0.2134 0.3412]);
set(s5,'position',[0.4108 0.1533 0.2134 0.3412]);
set(s6,'position',[0.6913 0.1533 0.2134 0.3412]);

hL = gridLegend([line{1},line{2},line{3},line{4}], 4,...
{'Isotropic - Voigt','Crystal Fabric - Voigt',...
'Isotropic - Reuss','Crystal Fabric - Reuss'} ,...
'location','south', 'Orientation','Horizontal');

set(hL,'Position',[0.02538 0.0203 0.9492 0.0505]);

export_fig(['Model_examples_VR_',plot_name,'.pdf'])

end

end