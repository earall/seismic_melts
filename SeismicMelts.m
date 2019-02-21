% SeismicMelts.m - Lee & Walker
%
% A script to calculate seismic properties when a melt fraction is
% introduced to a polycrystalline, polymineralic aggregate.
%
% To change model properties edit lines 44-56
%
% Please direct all questions to A. L. Lee
%
%% ***********************************************************************
%
clc
%clear all
close all force

%% Set variables

% Compatible with .ctf files:
filename = 'SIP20.ctf'; 

% Melt fraction muct be between 0 and 0.99:
melt = 0.1; 

% For caluclating velocities in a single direction use X, Y or Z:
direction = 'All'; 

% Change to your desired output directory:
path = ''; 

% Specify model: 'ISO' - No fabric, isotropic model
% 'SHP' - Shape and layered fabric models
% 'CPO' - Crystal fabric model
model = 'CPO'; 

% del - melt shape: oblate  < 1, sphere  = 1, prolate > 1
del = 0.01; % ignore if not using the shape fabric model

% horizontal inclusions: for del < 1, orientation = 90
%                        for del > 1, orientation = 0
% vertical inclusions:   for del < 1, orientation = 0
%                        for del > 1, orientation = 90
orientation = 90; % ignore if not using the shape fabric model

% add functions to matlab path
addpath('seismic_melts')
%% Specify plotting convention

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');


%% Import EBSD data

% creates an EBSD variable containing the data
% CS variable with crystal symmetries for each mineral
% List of phases present in sample
% Sample name for naming outout figures
[ebsd, CS, phase_names, sample_name] = get_ebsd(filename);

%% Calculate C tensor for solid phases

CT = c_tensor(ebsd, phase_names);

%% Calculate aggregate tensors for solid and melt

bound = 'Voigt';

[CTeff, rho] = tensor_melt(ebsd, CT, model, phase_names, melt, bound,...
    del, orientation);

%% Calculate seismic velocities for aggregate tensors

% Calculate velocities
seismics = calc_velocity(CTeff, melt, direction);


%% Plot 3D tensor to visualise seismic properties

if (strcmp(direction, 'All'))
    for i = 1:length(CTeff)
        output = (['Max Vp = ',num2str(max(seismics{1})),' km/s',newline...
                   'Max Vs1 = ',num2str(max(seismics{2})),' km/s',newline...
                   'Max Vs2 = ',num2str(max(seismics{3})),' km/s',newline...
                   'Max AVs = ',num2str(max(seismics{4})),' %',newline...
                   'Max Vp/Vs1 = ',num2str(max(seismics{5})),newline...
                   'Max Vp/Vs2 = ',num2str(max(seismics{6}))]);
        disp(['Maximum seismic properties for ',num2str(melt*100),...
            '% melt in the ',model,' model:'])
        disp(output)

        fname = [sample_name,'_',model];
        plot_tensor(seismics(i,:),fname, path)
    end
else
    output = (['Vp = ',num2str(seismics(2)),' km/s',newline...
               'Vs1 = ',num2str(seismics(3)),' km/s',newline...
               'Vs2 = ',num2str(seismics(4)),' km/s',newline...
               'AVs = ',num2str(seismics(5)),' %',newline...
               'Vp/Vs1 = ',num2str(seismics(6)),newline...
               'Vp/Vs2 = ',num2str(seismics(7))]);
    disp(['Seismic properties in the ',direction,' direction for ',...
        num2str(melt*100),'% melt in the ',model,' model:'])
    disp(output)
end
        