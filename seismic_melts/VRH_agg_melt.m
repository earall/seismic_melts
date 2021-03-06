function [C_matrix, rho_agg, C_melt, rho_melt] =...
    VRH_agg_melt( model, ebsd, C, phase_names, melt, bound)
% VRH_agg_melt - A. L. Lee
% Gives the seismic properties for the aggregate rock and a melt inclusion.
%
%   The VRH_agg_melt function calculates the aggregate density and the 
%   aggregate Voigt/Reuss C tensor at all melt values. Primarily the 
%   function uses the ebsd file to calculate the area fractions as a 
%   decimal for each of the solid phases in the sample.
%     
%   The aggregate density is calculated by multiplying the phase density by 
%   area fraction and summing for all phases. The individual C_Voigt 
%   tensors are multiplied by their area fractions so they are 
%   representative of the sample. They are then checked for small symmetry 
%   errors using the force_symmetry function. The individual C tensors are 
%   then summed to form an aggregate Voigt C tensor.
%   
%   The melt phases are all given the same isotropic tensor but their
%   densities vary as calculated by Preston, R. J. (2006) Magma density 
%   spreadsheet, www.gabbrosoft.org. 
% 
%     
%   INPUT
%   model - specify model: 'ISO' - No fabric, isotropic model
%                          'SHP' - Shape and layered fabric models
%                          'CPO' - Crystal fabric model
%   ebsd - EBSD file as generated by MTEX
%   C - C tensor for the solid phases
%   phase_names - list of phases present in sample
%   melt - melt fraction attributed to the sample (0-1)
%   bound - Voigt or Reuss
% 
%   OUTPUT
%   C_matrix - C tensor for the solid rock aggregate
%   rho_agg - Density for the solid rock aggregate
%   C_melt - C tensor for the melted portion of the rock
%   rho_melt - Density for the melted portion of the rock
% 
%   Please direct all questions to A. L. Lee
%	Copyright (c) 2019 Amicia Lee, see LICENSE
%
%
%% ***********************************************************************
%
% Calculating matrix for solid aggregate

ap = zeros(1,length(phase_names));
for i = 1:length(phase_names)
    ap(1,i) = length(ebsd(phase_names(i)));
end
afr = ap./sum(ap);

[melt_frac] = melt_fraction(phase_names, afr, melt);
phase_names_melt = melt_frac(:,1)';    
af = cell2mat(melt_frac(:,2)');

%% Inverse for Reuss bound
T = cell(1,length(phase_names));
if strcmp(bound, 'Reuss')
    for i = 1:length(phase_names)
        T{i} = inv(C{i});
    end
else
    T = C;
end

%%
T_ag_ind = cell(1,(length(phase_names_melt)));
for i = 1:length(phase_names_melt)
    if strendswith(phase_names_melt{i}, '_melt')
    else
        T_ag_ind{i} = times(T{i},af(i));
    end
end

%%

if melt == 0
    % Removing empty cells
    T_ag_ind = T_ag_ind(~cellfun('isempty', T_ag_ind));

    % Rectifying small symmetry errors
    T_ag_ind_symm = cell(1,(length(T_ag_ind)));
    for i = 1:(length(T_ag_ind))
        T_ag_ind_symm{1,i} = force_symmetry(T_ag_ind{1,i});
    end

    % Summing the C tensors
    T_agg = T_ag_ind_symm{1};
    if length(phase_names) > 1
        if  strcmp (model, 'ISO')
            for i = 2:(length(phase_names))
                T_agg = T_agg + T_ag_ind_symm{i};
            end
        elseif  strcmp (model, 'SHP')
            for i = 2:(length(phase_names))
                T_agg = T_agg + T_ag_ind_symm{i};
            end
        elseif strcmp (model, 'CPO')
            for i = 2:length(phase_names_melt)
                T_agg = T_agg + T_ag_ind_symm{i};
            end
        end
    end

else
    % Melt is added to the overall matrix for the progressive melting model
    if (strcmp(model, 'CPO'))
        for i = length(phase_names)+1:length(phase_names)*2
            Tm = tensor(get_phase_data(phase_names_melt{i}),...
                crystalSymmetry('O'));
            if strcmp(bound, 'Reuss')
                Tm = inv(Tm);
            end
            T_ag_ind{i} = Tm.*af(i);
        end
    end

    % Removing empty cells
    T_ag_ind = T_ag_ind(~cellfun('isempty', T_ag_ind));

    % Rectifying small symmetry errors
    T_ag_ind_symm = cell(1,(length(T_ag_ind)));
    for i = 1:(length(T_ag_ind))
        T_ag_ind_symm{1,i} = force_symmetry(T_ag_ind{1,i});
    end

    % Summing the C tensors
    T_agg = T_ag_ind_symm{1};
    if length(phase_names) > 1
        if  strcmp (model, 'ISO')
            for i = 2:(length(phase_names_melt) - length(phase_names))
                T_agg = T_agg + T_ag_ind_symm{i};
            end
        elseif  strcmp (model, 'SHP')
            for i = 2:(length(phase_names_melt) - length(phase_names))
                T_agg = T_agg + T_ag_ind_symm{i};
            end
        elseif strcmp (model, 'CPO')
            for i = 2:length(phase_names_melt)
                T_agg = T_agg + T_ag_ind_symm{i};
            end
        end
    end
  
end

% Inverse for Reuss
if strcmp(bound, 'Reuss')
    C_matrix = ten2mat(inv(T_agg));
else
    C_matrix = ten2mat(T_agg);
end


% Calculating matrix for melt inclusion
C_melt =   [[ 10.013	10.000	10.000	0.000	0.000	0.000];...
            [ 10.000	10.013	10.000	0.000	0.000	0.000];...
            [ 10.000	10.000	10.013	0.000	0.000	0.000];...
            [ 0.000     0.000	0.000	0.010	0.000	0.000];...
            [ 0.000     0.000	0.000	0.000	0.010	0.000];...
            [ 0.000     0.000	0.000	0.000	0.000	0.010]];

% Calculating the density for the sample
rho = zeros(1,length(phase_names_melt));
for i = 1:length(phase_names_melt)
    [ ~, rho(1,i)] = get_phase_data(phase_names_melt{i});
end

%Summing the separate densities according to area fraction
if strcmp (model, {'ISO','SHP'})
    rho_agg = sum(rho(1:length(phase_names)).*af(1:length(phase_names)));
    rho_melt = sum(rho(1+length(phase_names):end)...
        .*af((1+length(phase_names):end)));
else
    rho_agg = sum(af.*rho);
    rho_melt = 2.43;
end

% If no melt phases present, default melt density is 2.34
if rho_melt == 0
    rho_melt = 2.43;
end
      
% End of function
end