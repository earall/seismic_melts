function [seismics,CSTeff] = calc_seismics(ebsd, phase_names, melt,...
                             bound, direction)
% calc_velocity - A. L. Lee; Calculates seismic velocities for an EBSD 
% dataset with a specified melt fraction by calculation of c tensor
%   
%   This function acts as a script to calculate seismic properties for each
%   model. It shows the model variations dependent on melt inclusion
%   properties.
%
%   INPUT
%   ebsd - MTEX generated EBSD file
%   phase_names - list of phases in sample
% 
%   OUTPUT
%   seismics - for specified direction, seismic properties are output 
%              into a matrix: melt, vp, vs1, vs2, avs, vpvs1, vpvs2
%            - for 'All', seismic properties are output into a cell 
%              array: vp, vs1, vs2, avs, vpvs1, vpvs2, ps1, ps2
%   CSTeff - C tensor for each phase listed as a cell array
%
%% **************************************************************
%
    
for i = 1:length(ebsd)

    C_Voigt{i} = c_tensor(ebsd{i}, phase_names{i});

    CSTeff{1}{i} = tensor_iso(ebsd{i}, C_Voigt{i}, phase_names{i},...
        melt(i), bound); % No fabric model
    CSTeff{2}{i} = tensor_shp(ebsd{i}, C_Voigt{i}, phase_names{i},...
        melt(i), 0.01, 90, bound); % Shape fabric model: horizontal 
                                   % horizontal oblate melt inclusions
    CSTeff{3}{i} = tensor_shp(ebsd{i}, C_Voigt{i}, phase_names{i},...
        melt(i), 0.01, 0,  bound); % Shape fabric model:  
                                   % vertical oblate melt inclusions
    CSTeff{4}{i} = tensor_shp(ebsd{i}, C_Voigt{i}, phase_names{i},...
        melt(i), 100,  0,  bound); % Shape fabric model:
                                   % horizontal prolate melt inclusions
    CSTeff{5}{i} = tensor_shp(ebsd{i}, C_Voigt{i}, phase_names{i},...
        melt(i), 100,  90, bound); % Shape fabric model:
                                   % vertical prolate melt inclusions
    CSTeff{6}{i} = tensor_bac(ebsd{i}, C_Voigt{i}, phase_names{i},...
        melt(i), bound); % Layered fabric model
    CSTeff{7}{i} = tensor_cpo(ebsd{i}, C_Voigt{i}, phase_names{i},...
        melt(i), bound); % Crystal fabric model
end

% Calculate seismic properties
for i = 1:7
    for j = 1:length(ebsd)
        seismics{i}(j,:) = calc_velocity(CSTeff{i}{j}, melt(j), direction);
    end
end

end