function [C_Tensor_out ] = force_symmetry( C_Tensor_in )
%FORCE_SYMMETRY Imposes a symmetry to tensors that are not symmetric due to
%imaginary numbers
%
%   Forces a symmetry in asymmetric tensors by averaging identical values
%   across the mirror line. Symmetric tensors will not change during this
%   process 
% 
%   INPUT
%   C_Tensor_in - this tensor may be symmetric or asymmetric
%   
%   OUTPUT
%   C_Tensor_out - the tensor is now symmetric if it was not before
% 
%   Please direct all questions to A. L. Lee
%	Copyright (c) 2019 Amicia Lee, see LICENSE
% 
%% ***********************************************************************
%
% Converting tensor to MTEX matrix format
CT_in = matrix(C_Tensor_in);
%
% Converting tensor to simple matrix format
CM_in = zeros(6);
for i = 1:3
    for j = i:3
        for k = 1:3
            for l = k:3
                
                if i == j
                    m = i;
                else 
                    m = 9-i-j;
                end
                
                if k == l
                    n = k;
                else
                    n = 9-k-l;
                end
                CM_in(m,n) = CT_in(i,j,k,l);
            end
        end
    end
end
%
% Averaging to give symmetric values over the mirror line
CM_out = zeros(6);
for i = 1:6
    for j = 1:6
        CM_out(i,j) = 0.5 * (CM_in(i,j) + CM_in(j,i));
    end
end
%
% Convert simple matrix back to MTEX tensor format
C_Tensor_out = tensor(CM_out);


end

