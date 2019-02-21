function [melt_frac] = melt_fraction(phase_names, af, melt )
% melt_fraction - A. L. Lee
% Calculate melt area fractions and phase names for a given melt portion.
% 
%   If the given melt value > 0, the melt_fraction function will be used. 
%   This function calculates new area fractions depending on the given melt 
%   value. It also defines new phase names with the addition of '_melt' to 
%   distinguish the melt phase from the solid phase. This variation of the
%   'melt_fraction' function 'melts' all phases from the beginning,
%   disregarding metamorphic reactions. 
% 
%   INPUTS
%   phase_names - Phase names from the ebsd file
%   af - Area fraction of each phase within the sample
%   melt - individual melt portion as isolated from the melt_range
%   
%   OUTPUTS
%   melt_frac - Matrix of area fractions for 'melt' phases and adjusted 
%   area fractions fot the 'solid' phases
%
%   Please direct all questions to A. L. Lee
%	Copyright (c) 2019 Amicia Lee, see LICENSE
%   
%% ***********************************************************************
%   
% Setting up an empty cell array to populate with 'solid' phase names, area
% fractions and mineral type (felsic or mafic).


% MELT = 0
% Produces a matrix of phase name and corresponding area fraction
if melt == 0
    melt_frac = cell(2,length(phase_names));
    for i = 1:length(phase_names)
        melt_frac{1,i} = phase_names{i};
        melt_frac{2,i} = af(i);
    end
% MELT = 1
% Produces a matrix of phase names with 'melt' attributed to the phases
% with and area fraction of 1
elseif melt == 1
    melt_frac = cell(2,length(phase_names));
    for j = 1:length(phase_names)
        melt_frac{1,j} = sprintf('%s_melt',phase_names{j});
        melt_frac{2,j} = af(j);
    end
% 0 < MELT < 1
% Produces a matrix of phase name with 'melt' attributed to the melt
% fraction of the rock
else
    melt_frac = cell(2,length(phase_names)*2);
    for k = 1:length(phase_names)
        melt_frac{1,k} = phase_names{k};
        melt_frac{2,k} = af(k)*(1-melt);
        melt_frac{1,k+length(phase_names)} = sprintf('%s_melt',...
            phase_names{k});
        melt_frac{2,k+length(phase_names)} = af(k)*melt;
    end
end

% Removing empty rows from the matrix and transposing.
emptyCells = cellfun('isempty', melt_frac); 
melt_frac(all(emptyCells,2),:) = [];
melt_frac = melt_frac';
%
%
end