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

C_Voigt = c_tensor(ebsd, phase_names);

% No fabric model
CSTeff{1} = tensor_iso(ebsd, C_Voigt, phase_names,melt, bound); 
% Shape fabric model: horizontal oblate melt inclusions
CSTeff{2} = tensor_shp(ebsd, C_Voigt, phase_names,melt, 0.01, 90, bound); 
% Shape fabric model: vertical oblate melt inclusions
CSTeff{3} = tensor_shp(ebsd, C_Voigt, phase_names,melt, 0.01, 0,  bound);
% Shape fabric model: horizontal prolate melt inclusions
CSTeff{4} = tensor_shp(ebsd, C_Voigt, phase_names,melt, 100,  0,  bound);
% Shape fabric model: vertical prolate melt inclusions
CSTeff{5} = tensor_shp(ebsd, C_Voigt, phase_names,melt, 100,  90, bound);
% Layered fabric model
CSTeff{6} = tensor_bac(ebsd, C_Voigt, phase_names,melt, bound); 
% Crystal fabric model
CSTeff{7} = tensor_cpo(ebsd, C_Voigt, phase_names,melt, bound); 


% Calculate seismic properties

for i = 1:7
    seismics(i,:) = calc_velocity(CSTeff{i}, melt(i), direction);
end


end