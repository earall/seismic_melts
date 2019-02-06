function [VsVs0R, VsVs0L] = rayleigh_love(seismics)
%%

c = length(seismics);
r = length(seismics{1});

VsVs0R = zeros(r,c);
VsVs0L = zeros(r,c);

VsVs0R(:,1) = 1;
VsVs0L(:,1) = 1;
%%
for i = 1:c
    Vs1 = cell(1,r);
    Vs2 = cell(1,r);
    Ps1 = cell(1,r);
    Ps2 = cell(1,r);
   
    for j = 1:r
        Vs1{j} = seismics{i}{j,1};
        Vs2{j} = seismics{i}{j,2};
        Ps1{j} = seismics{i}{j,3};
        Ps2{j} = seismics{i}{j,4};
    end
    [VsR{i},~,VsL{i},~] = S_shp_surface_waves(Ps1,Ps2,Vs1,Vs2);

    for j = 1:r
    	VsVs0R(j,i) = real(VsR{i}{j}(91,1)/VsR{1}{j}(91,1));
        VsVs0L(j,i) = real(VsL{i}{j}(91,1)/VsL{1}{j}(91,1));
    end
end