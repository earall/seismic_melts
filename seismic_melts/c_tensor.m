function [C_Voigt, C_Reuss] = c_tensor( ebsd, phase_names )
% c_tensor - A. L. Lee; Calculates c tensor, density and area fraction of 
% an individual phase and adds data to a cell array.
% 
%   This function produces an individual Voigt C tensor for each phase in 
%   the rock, if melt = 0, a Reuss C tensor is also calculated. To 
%   calculate the tensors, the orientation distribution functions (ODF) of 
%   the phase is calculated using the MTEX 'calcODF' function (Hielscher 
%   and Schaeben, 2008; Mainprice et al., 2011). The elastic stiffness 
%   matrix is also required.
% 
%   The C tensors are then calculated using the tensor function with the 
%   elastic stiffness matrix, ODF and crystal symmetry (melt phases are 
%   given the cubic symmetry of Schoenflies group 'O'). This C tensor is 
%   then inputted to the MTEX 'calcTensor' function, where Voigt and Reuss 
%   C tensors are output (Mainprice et al., 2011).
% 
%   INPUT
%   ebsd - MTEX generated EBSD file
%   phase_names - list of phases in sample
% 
%   OUTPUT
%   C_Voigt - Voigt C tensor for each phase listed as a cell array
%   C_Reuss - Reuss C tensor for each phase listed as a cell array
% 
%   Please direct all questions to A. L. Lee
%
%% ***********************************************************************

% Setting up empty lists for values to be output to
C_Voigt = cell(1,length(phase_names));
C_Reuss = cell(1,length(phase_names));

%%
for i = 1:length(phase_names)
    % Calculating odf of phase    
    odf = calcODF(ebsd(phase_names{i}).orientations);
    % Acquiring elastic stiffness matrix and density of sample
    [M] = get_phase_data(phase_names(i));
    % Converting elastic stiffness matrix to a tensor
    C = tensor(M,odf.CS);
    % Calculating C tensors of Voigt, Reuss and Hill for the phase
    [C_Voigt{i},~,C_Reuss{i}] = calcTensor(ebsd(phase_names(i)).orientations,C);
end


end