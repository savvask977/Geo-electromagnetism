I = 0.005; % I = 0.005mA
AO = 6; %5.9436m-18 feet & 18 inches expressed in meters
rSoil = 30; %Ohm m
rCompactedClay = 200; %Ohm m
rLimestone = 500; %Ohm m
rGranite = 1500; %Ohm m
rShale = 50;
rn = 3;
rm = 2.4379; % Rm = Rn

% Calculate the voltage of subsurface layer with its true resistivity 

DVsoil= (rSoil * I * (rn - rm))/(4 * pi * (AO^2));
DVcc = (rCompactedClay * I * (rn - rm))/(4 * pi * (AO^2));
DVlimestone = (rLimestone * I * (rn - rm))/(4 * pi * (AO^2));
DVgranite = (rGranite * I * (rn - rm))/(4 * pi * (AO^2));
DVshale = (rShale * I * (rn - rm))/(4 * pi * (AO^2));

% now that we have the potential we can solve the inverse problem and 
% calculate the value of the resistivity

% complex multilayer model with shale surfaces
dSoil = 1 * AO; % 6m
dShale = 0.5 * AO + dSoil;% 9m
dCompactedClay = 2 * AO +dShale;% 21m
dShale2 = dCompactedClay + 0.5 * AO;% 24m
dLimestone = 3 * AO +dShale2; % 24 +18 = 42
dShale3 = dLimestone +0.5 * AO; % 45
dGranite = 5 * AO +dShale3; % 75
dShale4 = dGranite + 0.5 * AO; % 78
d = (1:dShale4);

% simple multilayer model with no shale surfaces
dso = 3; 
dcomc = 5 + dso;
dlime = 7 + dcomc;
dgr = 9 + dlime;
d2 = (1:dgr);



%% apparent resistivity calculations 

%simple simulation - model 1
    apr = zeros(24,1);
    v1 = zeros(24,1);
    for i = 1:dso
        apr(i) = (4 * pi * AO^2 * DVsoil)/ ((rn-rm) * I);
        v1(i) = DVsoil;
    end
    for i = dso:dcomc
        apr(i)= (4 * pi * AO^2 * DVcc)/ ((rn-rm) * I);
        v1(i) = DVcc;
    end
    for i = dcomc:dlime
        apr(i) = (4 * pi * AO^2 * DVlimestone)/ ((rn-rm) * I);
        v1(i) = DVlimestone;
    end
    for i = dlime:dgr
        apr(i) = (4 * pi * AO^2 * DVgranite)/ ((rn-rm) * I);
        v1(i) = DVgranite;
    end

    
%complex simulation 
app_res = zeros(78,1);
V = zeros(78,1);

    for i = 1:dSoil
        app_res(i) = (4 * pi * AO^2 * DVsoil)/ ((rn-rm) * I);
        V(i) = DVsoil;
    end
    for i = dSoil:dShale
          app_res(i) = (4 * pi * AO^2 * DVshale)/ ((rn-rm) * I);
          V(i) = DVshale;
    end
    for i = dShale:dCompactedClay
        app_res(i) = (4 * pi * AO^2 * DVcc)/ ((rn-rm) * I);
        V(i) = DVcc;
    end
    for i = dCompactedClay:dShale2
          app_res(i) = (4 * pi * AO^2 * DVshale)/ ((rn-rm) * I);
          V(i) = DVshale;
    end
    for i = dShale2:dLimestone
        app_res(i) = (4 * pi * AO^2 * DVlimestone)/ ((rn-rm) * I);
        V(i) = DVlimestone;
    end
    for i = dLimestone:dShale3
          app_res(i) = (4 * pi * AO^2 * DVshale)/ ((rn-rm) * I);
          V(i) = DVshale;
    end
    for i = dShale3:dGranite
        app_res(i) = (4 * pi * AO^2 * DVgranite)/ ((rn-rm) * I);
        V(i) = DVgranite;
    end
    for i = dGranite:dShale4
          app_res(i) = (4 * pi * AO^2 * DVshale)/ ((rn-rm) * I);
          V(i) = DVshale;
    end

    
%% plot resistivities for 2 models

subplot(1,2,1)
plot(app_res, d, 'col','#0072BD','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(6,':k','Soil');
yline(9,':k','Shale');
yline(21,':k','Compacted Clay');
yline(24,':k','Shale');
yline(42,':k','Limestone');
yline(45,':k','Shale');
yline(75,':k','Granite');
yline(78,':k','Shale');
title('Model 2 Resistivity to Depth')
xlabel('Resistivity(Ohm m)')
ylabel('Depth(m)')
legend({'Model2', 'layers'},'Location','northeast', 'FontSize',5);

subplot(1,2,2)
plot(apr, d2, 'col','#0072BD','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(3,':k','Soil');
yline(8,':k','Compacted Clay');
yline(15,':k','Limestone');
yline(24,':k','Granite');
title('Model 1 Resistivity to Depth')
xlabel('Resistivity(Ohm m)')
ylabel('Depth(m)')
legend({'Model1', 'layers'},'Location','northeast', 'FontSize',5);


%% plot potentials of the 2 models
subplot(1,2,1)
plot(V, d, 'col','#77AC30','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(6,':k','Soil');
yline(9,':k','Shale');
yline(21,':k','Compacted Clay');
yline(24,':k','Shale');
yline(42,':k','Limestone');
yline(45,':k','Shale');
yline(75,':k','Granite');
yline(78,':k','Shale');
title('Model 2 Potential to Depth')
xlabel('Potential(V)')
ylabel('Depth(m)')
legend({'V2', 'layers'},'Location','northeast', 'FontSize',5);

subplot(1,2,2)
plot(v1, d2, 'col','#77AC30','Linewidth', 2);
set(gca,'XAxisLocation','top','YAxisLocation','left','ydir','reverse');
yline(3,':k','Soil');
yline(8,':k','Compacted Clay');
yline(15,':k','Limestone');
yline(24,':k','Granite');
title('Model 1 Potential to Depth')
xlabel('Potential(V)')
ylabel('Depth(m)')
legend({'V1', 'layers'},'Location','northeast', 'FontSize',5);


%% resistivity to spacing diagram for short normal logging
spacing2 = [5.94 11.88 23.76 47.52 95.04 190.08 380.16 760.32];
model2 = [30, 50, 200,50, 500,50, 1500,50];
spacing1 = [5.94 11.88 23.76 47.52];
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
