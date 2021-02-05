I = 0.005; % I = 0.005mA
AMs = 0.4; % short normal resistivity 16 inches to m
AMl = 1.6; % long normal resistivity 64 inches to m
AM = [AMs, AMl];
rSoil = 30; %Ohm m
rCompactedClay = 200; %Ohm m
rLimestone = 500; %Ohm m
rGranite = 1500; %Ohm m
rShale = 50; %Ohm m

Vsoil = zeros(1);
VCompactedClay = zeros(1);
VLimestone = zeros(1);
VGranite = zeros(1);
Vshale = zeros(1);

% Calculate the voltage of its subsurface layer with its true resistivity 
for i = 1:length(AM)
    Vsoil(i) = (rSoil * I) / (4 * pi * AM(i));
    VCompactedClay(i) = (rCompactedClay * I) / (4 * pi * AM(i));
    VLimestone(i) = (rLimestone * I) / (4 * pi * AM(i));
    VGranite(i) = (rGranite * I) / (4 * pi * AM(i));
    Vshale(i) = (rShale * I) / (4 * pi * AM(i));
end

% Having the voltages we will calculate the resistivity
dSoil = 5 * AMs; % 2m
dShale = 2.5 * AMs + dSoil;% 3m
dCompactedClay = 10 * AMs +dShale;% 7m
dShale2 = dCompactedClay + 1;% 8m
dLimestone = 15 * AMs +dShale2; % 6m +8 =14
dShale3 = dLimestone + 1; % 15
dGranite = 20 * AMs +dShale3; % 8m + 15 = 23
dShale4 = dGranite + 1; % 24m
d = (1:dShale4);

dso = 3; 
dcomc = 5 + dso;
dlime = 7 + dcomc;
dgr = 9 + dlime;

%% Short Normal Resistivity

% model1
apr = zeros(24,2);
V2 = zeros(24,2);
for j = 1:length(AM)
    for i = 1:dso
        apr(i,j) = 4 * pi * AM(j) * (Vsoil(j) / I);
        V2(i,j) = Vsoil(j);
    end
    for i = dso:dcomc
        apr(i,j) = (4 * pi * AM(j)) * (VCompactedClay(j) / I);
        V2(i,j) = VCompactedClay(j);
    end
    for i = dcomc:dlime
        apr(i,j) = (4 * pi * AM(j)) * (VLimestone(j) / I);
        V2(i,j) = VLimestone(j);
    end
    for i = dlime:dgr
        apr(i,j) = (4 * pi * AM(j)) * (VGranite(j) / I);
        V2(i,j) = VGranite(j);
    end
end

%model2
app_res = zeros(24,2);
V = zeros(24,2);
for j = 1:length(AM)
    for i = 1:dSoil
        app_res(i,j) = 4 * pi * AM(j) * (Vsoil(j) / I);
        V(i,j) = Vsoil(j);
    end
    for i = dSoil:dShale
          app_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          V(i,j) = Vshale(j);
    end
    for i = dShale:dCompactedClay
        app_res(i,j) = (4 * pi * AM(j)) * (VCompactedClay(j) / I);
        V(i,j) = VCompactedClay(j);
    end
    for i = dCompactedClay:dShale2
          app_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          V(i,j) = Vshale(j);
    end
    for i = dShale2:dLimestone
        app_res(i,j) = (4 * pi * AM(j)) * (VLimestone(j) / I);
        V(i,j) = VLimestone(j);
    end
    for i = dLimestone:dShale3
          app_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          V(i,j) = Vshale(j);
    end
    for i = dShale3:dGranite
        app_res(i,j) = (4 * pi * AM(j)) * (VGranite(j) / I);
        V(i,j) = VGranite(j);
    end
    for i = dGranite:dShale4
          app_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          V(i,j) = Vshale(j);
    end
end

%% LONG Normal Resistivity
ldSoil = 5 * AMl; % 2m
ldShale = 2.5 * AMl + ldSoil;% 3m
ldCompactedClay = 10 * AMl +ldShale;% 7m
ldShale2 = ldCompactedClay + 1;% 8m
ldLimestone = 15 * AMl +ldShale2; % 6m +8 =14
ldShale3 = ldLimestone + 1; % 15
ldGranite = 20 * AMl +ldShale3; % 8m + 15 = 23
ldShale4 = ldGranite + 1; % 24m
dl = (1:ldShale4);

ldso = 3; 
ldcomc = 5 + ldso;
ldlime = 7 + ldcomc;
ldgr = 9 + ldlime;
ld1 = (1:ldgr);

% model1
lapr = zeros(24,2);
lV2 = zeros(24,2);
for j = 1:length(AM)
    for i = 1:ldso
        lapr(i,j) = 4 * pi * AM(j) * (Vsoil(j) / I);
        lV2(i,j) = Vsoil(j);
    end
    for i = ldso:ldcomc
        lapr(i,j) = (4 * pi * AM(j)) * (VCompactedClay(j) / I);
        lV2(i,j) = VCompactedClay(j);
    end
    for i = ldcomc:ldlime
        lapr(i,j) = (4 * pi * AM(j)) * (VLimestone(j) / I);
        lV2(i,j) = VLimestone(j);
    end
    for i = ldlime:ldgr
        lapr(i,j) = (4 * pi * AM(j)) * (VGranite(j) / I);
        lV2(i,j) = VGranite(j);
    end
end

% model2
lapp_res = zeros(24,2);
lV = zeros(24,2);
for j = 1:length(AM)
    for i = 1:ldSoil
        lapp_res(i,j) = 4 * pi * AM(j) * (Vsoil(j) / I);
        lV(i,j) = Vsoil(j);
    end
    for i = ldSoil:ldShale
          lapp_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          lV(i,j) = Vshale(j);
    end
    for i = ldShale:ldCompactedClay
        lapp_res(i,j) = (4 * pi * AM(j)) * (VCompactedClay(j) / I);
        lV(i,j) = VCompactedClay(j);
    end
    for i = ldCompactedClay:ldShale2
          lapp_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          lV(i,j) = Vshale(j);
    end
    for i = ldShale2:ldLimestone
        lapp_res(i,j) = (4 * pi * AM(j)) * (VLimestone(j) / I);
        lV(i,j) = VLimestone(j);
    end
    for i = ldLimestone:ldShale3
          lapp_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          lV(i,j) = Vshale(j);
    end
    for i = ldShale3:ldGranite
        lapp_res(i,j) = (4 * pi * AM(j)) * (VGranite(j) / I);
        lV(i,j) = VGranite(j);
    end
    for i = ldGranite:ldShale4
          lapp_res(i,j) = 4 * pi * AM(j) * (Vshale(j) / I);
          lV(i,j) = Vshale(j);
    end
end


%% resistivity to depth diagrams for the 2 models
figure
subplot(1,2,1)
plot(app_res(:,1), d, 'col','#0072BD','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(2,':k','Soil');
yline(3,':k','Shale');
yline(7,':k','Compacted Clay');
yline(8,':k','Shale');
yline(14,':k','Limestone');
yline(15,':k','Shale');
yline(23,':k','Granite');
yline(25,':k','Shale');
title('Resistivity to Depth - Normal Short Spacing')
xlabel('Resistivity(Ohm m)')
ylabel('Depth(m)')
legend({'Model2', 'layers'},'Location','northeast', 'FontSize',5);

subplot(1,2,2)
plot(lapp_res(:,2), dl, 'col','#D95319','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(8,':k','Soil');
yline(12,':k','Shale');
yline(28,':k','Compacted Clay');
yline(29,':k','Shale');
yline(53,':k','Limestone');
yline(54,':k','Shale');
yline(86,':k','Granite');
yline(87,':k','Shale');
title('Resistivity to Depth - Normal Long Spacing')
xlabel('Resistivity(Ohm m)')
ylabel('Depth(m)')
legend({'Model2', 'layers'},'Location','northeast', 'FontSize',5);

figure
subplot(1,2,1)
plot(apr(:,1), d, 'col','#0072BD','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(3,':k','Soil');
yline(7,':k','Compacted Clay');
yline(15,':k','Limestone');
yline(23,':k','Granite');
title('Resistivity to Depth - Normal Short Spacing')
xlabel('Resistivity(Ohm m)')
ylabel('Depth(m)')
legend({'Model1', 'layers'},'Location','northeast', 'FontSize',5);

subplot(1,2,2)
plot(lapr(:,2), ld1, 'col','#D95319','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(3,':k','Soil');
yline(7,':k','Compacted Clay');
yline(15,':k','Limestone');
yline(23,':k','Granite');
title('Resistivity to Depth - Normal Long Spacing')
xlabel('Resistivity(Ohm m)')
ylabel('Depth(m)')
legend({'Model1', 'layers'},'Location','northeast', 'FontSize',5);
%% potential to depth diagrams for short normal logging
figure
subplot(1,2,1)
plot(V(:,1), d, 'col','#EDB120','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(2,':k','Soil');
yline(3,':k','Shale');
yline(7,':k','Compacted Clay');
yline(8,':k','Shale');
yline(14,':k','Limestone');
yline(15,':k','Shale');
yline(23,':k','Granite');
yline(25,':k','Shale');
title('Potential to Depth')
xlabel('Potential(V)')
ylabel('Depth(m)')
legend({'V2', 'layers'},'Location','northeast', 'FontSize',5);

subplot(1,2,2)
plot(lV(:,2), dl, 'col','#7E2F8E','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(8,':k','Soil');
yline(12,':k','Shale');
yline(28,':k','Compacted Clay');
yline(29,':k','Shale');
yline(53,':k','Limestone');
yline(54,':k','Shale');
yline(86,':k','Granite');
yline(87,':k','Shale');
title('Potential to Depth')
xlabel('Potential(V)')
ylabel('Depth(m)')
legend({'V2', 'layers'},'Location','northeast', 'FontSize',5);



figure
subplot(1,2,1)
plot(V2(:,1), d, 'col','#EDB120','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(2,':k','Soil');
yline(7,':k','Compacted Clay');
yline(15,':k','Limestone');
yline(23,':k','Granite');
title('Potential to Depth - Normal Short Spacing')
xlabel('Potential(V)')
ylabel('Depth(m)')
legend({'V1', 'layers'},'Location','northeast', 'FontSize',5);

subplot(1,2,2)
plot(lV2(:,2), ld1, 'col','#7E2F8E','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(2,':k','Soil');
yline(7,':k','Compacted Clay');
yline(15,':k','Limestone');
yline(23,':k','Granite');
title('Potential to Depth - Normal Long Spacing')
xlabel('Potential(V)')
ylabel('Depth(m)')
legend({'V1', 'layers'},'Location','northeast', 'FontSize',5);
%% resistivity to spacing diagram for short normal logging

spacing2 = [0.2 0.4 0.8 1.6 3.2 6.4 12.8 25.6];
model2 = [30, 50, 200,50, 500,50, 1500,50];
spacing1 = [0.2 0.4 0.8 1.6];
model1 =[30,200,500,1500];
figure 
plot(spacing2,model2,'col','#4DBEEE','Linewidth', 2);
title('Model 2 Apparent Resistivity compared to electrode spacing')
xlabel('Electrode Spacing (m)')
ylabel('Apparent Resistivity(Ohm m)')
legend({'ARes'},'Location','northeast', 'FontSize',10);

figure
plot(spacing1, model1,'col','#A2142F','Linewidth', 2);
title('Model 1 Apparent Resistivity compared to electrode spacing')
xlabel('Electrode Spacing (m)')
ylabel('Apparent Resistivity(Ohm m)')
legend({'ARes'},'Location','northeast', 'FontSize',10);

