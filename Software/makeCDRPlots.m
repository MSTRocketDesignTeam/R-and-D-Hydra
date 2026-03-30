close all

load("cdr_data_plots.mat")
% m to mm
xdata = xdata .* 1E3;
fig_stress = figure();
fig_temp = figure();
ax_stress = axes(fig_stress);
ax_temp = axes(fig_temp);
hold(ax_stress, "on");
hold(ax_temp, "on");
xlabel(ax_stress, "mm from nozzle exit plane");
ylabel(ax_stress, "MPa");
xlabel(ax_temp, "mm from nozzle exit plane");
ylabel(ax_temp, "deg C");

plot(ax_stress, xdata, ydata1);
plot(ax_temp, xdata, ydata2);