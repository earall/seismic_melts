function [Love_X, Rayleigh_X, Love_Y, Rayleigh_Y] = surface_wave(seismics)

%%
%seismics = seismics_pol{5};

for i = 1:length(seismics)
vs1_X(i) = seismics{i,1}(1);
vs1_Y(i) = seismics{i,1}(2);
vs2_X(i) = seismics{i,2}(1);
vs2_Y(i) = seismics{i,2}(2);
ps1_X{i} = seismics{i,3}(1);
ps1_Y{i} = seismics{i,3}(2);
ps2_X{i} = seismics{i,4}(1);
ps2_Y{i} = seismics{i,4}(2);
end

%%

for i = 1:length(seismics)
if ps1_X{i}.z > 0.8
    Love_X(i,1) = vs1_X(i);
    Rayleigh_X(i,1) = vs2_X(i);
elseif ps1_X{i}.z < -0.8
    Love_X(i,1) = vs1_X(i);
    Rayleigh_X(i,1) = vs2_X(i);
elseif ps2_X{i}.z > -0.2
    Love_X(i,1) = vs2_X(i);
    Rayleigh_X(i,1) = vs1_X(i);
elseif ps2_X{i}.z < 0.2
    Love_X(i,1) = vs2_X(i);
    Rayleigh_X(i,1) = vs1_X(i);
elseif ps1_X{i}.z > 0 && ps1_X{i}.z > ps2_X{i}.z
    Love_X(i,1) = vs1_X(i);
    Rayleigh_X(i,1) = vs2_X(i);
elseif ps1_X{i}.z < 0 && ps1_X{i}.z < ps2_X{i}.z
    Love_X(i,1) = vs1_X(i);
    Rayleigh_X(i,1) = vs2_X(i);
elseif ps2_X{i}.z > 0 && ps2_X{i}.z > ps1_X{i}.z
    Love_X(i,1) = vs2_X(i);
    Rayleigh_X(i,1) = vs1_X(i);
elseif ps2_X{i}.z < 0 && ps2_X{i}.z < ps1_X{i}.z
    Love_X(i,1) = vs2_X(i);
    Rayleigh_X(i,1) = vs1_X(i);
else
    Love_X(i,1) = vs1_X(i);
    Rayleigh_X(i,1) = vs2_X(i);
end

if ps1_Y{i}.z > 0.8
    Love_Y(i,1) = vs1_Y(i);
    Rayleigh_Y(i,1) = vs2_Y(i);
elseif ps1_Y{i}.z < -0.8
    Love_Y(i,1) = vs1_Y(i);
    Rayleigh_Y(i,1) = vs2_Y(i);
elseif ps2_Y{i}.z > -0.2
    Love_Y(i,1) = vs2_Y(i);
    Rayleigh_Y(i,1) = vs1_Y(i);
elseif ps2_Y{i}.z < 0.2
    Love_Y(i,1) = vs2_Y(i); 
    Rayleigh_Y(i,1) = vs1_Y(i);
elseif ps1_Y{i}.z > 0 && ps1_Y{i}.z > ps2_Y{i}.z
    Love_Y(i,1) = vs1_Y(i);
    Rayleigh_Y(i,1) = vs2_Y(i);
elseif ps1_Y{i}.z < 0 && ps1_Y{i}.z < ps2_Y{i}.z
    Love_Y(i,1) = vs1_Y(i);
    Rayleigh_Y(i,1) = vs2_Y(i);
elseif ps2_Y{i}.z > 0 && ps2_Y{i}.z > ps1_Y{i}.z
    Love_Y(i,1) = vs2_Y(i);
    Rayleigh_Y(i,1) = vs1_Y(i);
elseif ps2_Y{i}.z < 0 && ps2_Y{i}.z < ps1_Y{i}.z
    Love_Y(i,1) = vs2_Y(i);
    Rayleigh_Y(i,1) = vs1_Y(i);
else
    Love_Y(i,1) = vs1_Y(i);
    Rayleigh_Y(i,1) = vs2_Y(i);
end
end

%%
for i = 1:length(seismics)
    VsVs0L_X(i,:) = Love_X(i,:)./Love_X(1,:);
    VsVs0R_X(i,:) = Rayleigh_X(i,:)./Rayleigh_X(1,:);
    VsVs0L_Y(i,:) = Love_Y(i,:)./Love_Y(1,:);
    VsVs0R_Y(i,:) = Rayleigh_Y(i,:)./Rayleigh_Y(1,:);
end

end