function [ebsd, CS, phase_names, sample_name] = get_ebsd(filename)
% GET_EBSD Function to correllate crystal symmetry to phase order,
% adding 'notIndexed' to unused phases.
% 
%   The function reads the EBSD file to find how many and what phases are
%   present in the sample. It also amends the names of phases to the ones 
%   accepted in the melt model, accessory phases are also discounted at 
%   this stage. 
%     
%   The outputs of the get_symmetry function are a list of crystal 
%   symmetries (CS) for each nominated phase present in the sample and a 
%   list of those phase names. If the phase is not present in the database,
%   an error message will be displayed and the code will fail.
%    
%
%   INPUT
%   filename - .ctf file
%   
%   OUTPUT
%   CS - Crystal symmetries for the file
%   phase_names - List of phases within the sample
% 
%
%   Please direct all questions to A. L. Lee
%
%% ***********************************************************************
%
% Opens ctf file
fileID = fopen(filename, 'r');
formatSpec = '%s %s %s %s %s %s %s %s %s %s %s %s %s';
header = textscan(fileID,formatSpec,30,'CommentStyle','##',...
    'Delimiter','\t');
	
% Finding the number of phases present from the ctf header
number_of_phases = str2double(cell2mat(header{1,2}(13)));
if number_of_phases < 20
    number_of_phases = str2double(cell2mat(header{1,2}(13)));
    % phases_present represents all phases indexed via ebsd
    phase_end = 13 + number_of_phases;
    phases_present = header{1,3}(14:phase_end);
    fclose(fileID);
else
    number_of_phases = str2double(cell2mat(header{1,2}(14)));
    % phases_present represents all phases indexed via ebsd
    phase_end = 14 + number_of_phases;
    phases_present = header{1,3}(15:phase_end);
    fclose(fileID);
end
%%
% Changing ebsd phase names to more appropriate ones
all_phases = cell(1,number_of_phases);
phase_present = cell(1,number_of_phases);
% Correlating crystal symmetries to phases in the same order as ctf file
CS = cell(1,(number_of_phases + 1));
CS{1} = 'notIndexed';
for i = 1:number_of_phases
    phase = (char(phases_present(i)));
    switch(phase)
        case 'Quartz-new'
            all_phases{i} = 'Quartz';
        case 'An38 Andesine'
            all_phases{i} = 'An38 And';
        case 'K_Feldspar'
            all_phases{i} = 'KFeldspar';
        case 'Orthoclase'
            all_phases{i} = 'KFeldspar';
        case 'Biotite - C 2/c'
            all_phases{i} = 'Biotite';
        case 'Hornblende  C2/m'
            all_phases{i} = 'Hornblende';
        case 'Enstatite  Opx AV77'
            all_phases{i} = 'Enstatite';
        case 'hyperst'
            all_phases{i} = 'Hypersthene';
        case 'Diopside   CaMgSi2O6'
            all_phases{i} = 'Diopside';
% If there are phase names to change, add them here
        otherwise
            all_phases{i} = phase;
			
    end 
    [~, ~, CS{i+1}] = get_phase_data(all_phases{i});
    
    if (strcmp(CS{i+1}, 'notIndexed'))
        phase_present{i} = [];
    else
        phase_present{i} = all_phases{i};
    end
    
end

% plotting convention
setMTEXpref('xAxisDirection','east');
setMTEXpref('zAxisDirection','intoPlane');

phase_names = phase_present(~cellfun('isempty',phase_present));

ebsd = loadEBSD(filename,CS,'interface','ctf',...
    'convertEuler2SpatialReferenceFrame');

sample_name = filename(end-8:end-4);
end