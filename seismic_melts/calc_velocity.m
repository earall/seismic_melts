function [seismics] = calc_velocity(CSTeff, melt, direction)
% calc_velocity.m - A. L. Lee
% Calculates seismic properties from a stiffness tensor.
% 
%   This function gives the seismic properties produced by the calculated 
%   stiffness tensors in the no, shape, layered and crystal fabric models. 
%   This uses the velocity function within MTEX. This function has a 
%   'direction' option where the user can select 'All' which outputs a 
%   3D tensor to allow plotting seismic properties as a 3D tensor. 
%   Selecting the 'X', 'Y' or 'Z' options specifies a wave propagation 
%   direction in one of these directions, this can be used to simulate 
%   surface wave data (X or Y) or teleseismic data (Z).
%
%   INPUT
%   CSTeff - MTEX stiffness tensor
%   melt - melt fraction (0-1) 
%   direction - Wave propagation direction, X, Y or Z directions. If you 
%   would like to plot 3D tensors please use 'All'.
%   
%   OUTPUT
%   seismics - for specified direction, seismic properties are output into 
%              a matrix: melt, vp, vs1, vs2, avs, vpvs1, vpvs2
%            - for 'All', seismic properties are output into a cell array:
%              vp, vs1, vs2, avs, vpvs1, vpvs2, ps1, ps2
%
%   Please direct all questions to A. L. Lee
%
%% ***********************************************************************
%
% Specifying the wave propagation direction

% Set the mtex coordinate system
setMTEXpref('zAxisDirection','north');
setMTEXpref('yAxisDirection','outofplane');
plota2east;


% All velocity properties to plot 3D tensors 
if (strcmp(direction, 'All'))
    % vp, vs1, vs2 are calculated from the stiffness tensor
    [vp,vs1,vs2,~,ps1,ps2] = CSTeff.velocity;
    % output as a cell array
    seismics = {vp,vs1,vs2,(200*(vs1-vs2)./(vs1+vs2)),...
        (vp./vs1),(vp./vs2),ps1,ps2};

% Horizontal waves
elseif (strcmp(direction, 'X'))
    v = vector3d(1,0,0);
    % vp, vs1, vs2 are calculated from the stiffness tensor
    [vp,vs1,vs2] = velocity(CSTeff,v);
    % output as a matrix
    seismics = real([melt,vp,vs1,vs2,(200*(vs1-vs2)./(vs1+vs2)),...
        (vp./vs1),(vp./vs2)]);
    
% Horizontal waves
elseif (strcmp(direction, 'Y'))
    v = vector3d(0,-1,0);
    % vp, vs1, vs2 are calculated from the stiffness tensor
    [vp,vs1,vs2] = velocity(CSTeff,v);
    % output as a matrix
    seismics = real([melt,vp,vs1,vs2,(200*(vs1-vs2)./(vs1+vs2)),...
        (vp./vs1),(vp./vs2)]);

% Horizontal waves
elseif (strcmp(direction, 'Z'))
    v = vector3d(0,0,-1);
    % vp, vs1, vs2 are calculated from the stiffness tensor
    [vp,vs1,vs2] = velocity(CSTeff,v);
    % output as a matrix
    seismics = real([melt,vp,vs1,vs2,(200*(vs1-vs2)./(vs1+vs2)),...
        (vp./vs1),(vp./vs2)]);  
    
% End of function
end