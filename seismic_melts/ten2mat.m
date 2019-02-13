function C_mat = ten2mat(C_tensor)
% ten2mat - A. L. Lee
% Converts tensor to matrix
%
%   Convert C tensor to a matrix to allow input to fabric models to define
%   melt inclusion shape
%     
%   INPUT
%   C_tensor - Voigt or Reuss tensor
% 
%   OUTPUT
%   C_mat - Matrix
% 
%   Please direct all questions to A. L. Lee
%
%   
%% ***********************************************************************
%
C_ten = matrix(C_tensor);

C_mat_i = zeros(6);
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
                C_mat_i(m,n) = C_ten(i,j,k,l);
            end
        end
    end
end

C_mat = real(C_mat_i);

end