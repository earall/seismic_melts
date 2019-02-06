function [vR,pR,vL,pL] = surface_waves(ps1,ps2,vs1,vs2)

%%
% ps1 = Ps1;
% ps2 = Ps2;
% vs1 = Vs1;
% vs2 = Vs2;

Rayleigh = zeros(1,2);
Love = zeros(1,2);

type = zeros(1,2);
for i = 1:2
    %type(i) = 0;
    if ps1{i}(207).y == 0
        Love(i) = 1;
        Rayleigh(i) = 2;
    elseif ps2{i}(207).y == 0
        Love(i) = 2;
        Rayleigh(i) = 1;
    elseif ps2{i}(207).y < 0
        if ps1{i}(207).y > ps2{i}(207).y
        Love(i) = 2;
        Rayleigh(i) = 1;
        elseif ps1{i}(207).y < ps2{i}(207).y
        Love(i) = 1;
        Rayleigh(i) = 2;
        end
    elseif ps1{i}(207).y > 0
        if ps1{i}(207).y < ps2{i}(207).y
        Love(i) = 1;
        Rayleigh(i) = 2;
        elseif ps1{i}(207).y > ps2{i}(207).y
        Love(i) = 2;
        Rayleigh(i) = 1;
        end
    end
end
%%
vR = cell(length(vs1),1);
pR = cell(length(ps1),1);
vL = cell(length(vs1),1);
pL = cell(length(ps1),1);

%type(2) = 2;

for i = 1:length(vs1)
    if Rayleigh(2) == 1
    vR(i) = vs1(i);
    vL(i) = vs2(i);
    pR(i) = ps1(i);
    pL(i) = ps2(i);
    elseif Rayleigh(2) == 2
    vR(i) = vs1(i);
    vL(i) = vs2(i);
    pR(i) = ps1(i);
    pL(i) = ps2(i);
    elseif type(2) == 0
        if Rayleigh(1) == 1
        vR(i) = vs1(i);
        vL(i) = vs2(i);
        pR(i) = ps1(i);
        pL(i) = ps2(i);
        elseif Rayleigh(1) == 2
        vR(i) = vs1(i);
        vL(i) = vs2(i);
        pR(i) = ps1(i);
        pL(i) = ps2(i);
        end
    end
end
