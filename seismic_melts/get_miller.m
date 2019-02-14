function [h] = get_miller(phase, symmetry )
%GET_MILLER Gives miller indicies for 'phase' in database
%   
%   Depending on which phase is plotted, different Miller Indices will be 
%   plotted. The get_miller function runs through the database to find the 
%   relevant Miller indices for the given phase.
%     
%   e.g. 100, 010, 001 for k-feldspar 
%        11-20, 1010, 0001, 10-11, 01-1?1 for quartz. 
%              
%   If the phase is not present in the database, an error message will be 
%   displayed and the code will fail.
% 
%   INPUT
%   phase - specified mineral phase
%   symmetry - CS as called from ebsd file
%   
%   OUTPUT
%   h = Miller indicies
% 
%   If phase not present in database - 'ERROR'
%
%% ***********************************************************************

    if (strcmp(phase, 'Scapolite'))
       h = [Miller(1, 0, 0, symmetry),...
            Miller(0, 0, 1, symmetry),...
            Miller(1, 1, 0, symmetry)...
            Miller(1, 1, 1, symmetry)];
        
    elseif strcmp(phase, 'Almandine')||strcmp(phase, 'Pyrope')
       h = [Miller(1, 0, 0, symmetry),...
            Miller(1, 1, 0, symmetry),...
            Miller(1, 1, 1, symmetry)];

    elseif (strcmp(phase, 'Quartz'))...
         || strcmp(phase,'Ilmenite')
       h = [Miller(2,-1, -1, 0, symmetry),...
            Miller(1, 0, -1, 0, symmetry),...
            Miller(0, 0, 0, 1, symmetry),...
            Miller(1, 0, -1, 1, symmetry),...
            Miller(0, 1, -1, 1, symmetry)];
    
%     elseif strcmp(phase, 'An38 And') ||...
%            strcmp(phase,'An25 Olig') ||...
%            strcmp(phase,'An67 Lab') ||...
%            strcmp(phase,'An85 Byt')
%        h = [Miller(1,0, 0, symmetry),...
%             Miller(0, 1, 0, symmetry),...
%             Miller(0, 0, 1, symmetry),...
%             Miller(-1, 0, 0, symmetry),...
%             Miller(0, -1, 0, symmetry),...
%             Miller(0, 0, -1, symmetry)];
    else
       h = [Miller(1, 0, 0, symmetry),...
             Miller(0, 1, 0, symmetry),...
             Miller(0, 0, 1, symmetry)];
       
    end

end