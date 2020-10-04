% Licensed under GPL-3.0-or-later, check attached LICENSE file

function plot_amplitude(obj,f,frf,paramPlot)
% Plots the amplitude of the FRF
%
%    :param f: Frequency
%    :type f: vector
%    :param frf: Frequency response function
%    :type frf: vector
%    :param paramPlot: Additional parameters for visualization (type of amplitude, �)
%    :type paramPlot: struct
%    :return: Figure with amplitude of FRF

amplitudeMeasure = paramPlot.amplitudeMeasure;
type = obj.experimentFRF.type;
unit = obj.experimentFRF.unit;
figure
k=0;

for i=1:size(frf,3)
    for j = 1:size(frf,2)
        k=k+1;
        absFRF = abs(frf(:,j,i));
        Color = obj.ColorHandler.getColor(k);
        LineStyle = '-';
        LineWidth = 0.5;
        DisplayName = obj.experimentFRF.descriptionsH{j,i};
        hold on
        
        switch amplitudeMeasure
            case 'lin'
                plot(f,absFRF,'LineWidth',LineWidth,'DisplayName',DisplayName,'Color',Color,'LineStyle',LineStyle)
            case 'log'
                plot(f,absFRF,'LineWidth',LineWidth,'DisplayName',DisplayName,'Color',Color,'LineStyle',LineStyle)
                ax=gca;
                ax.YScale = 'log';
            case 'dB'
                plot(f,db20(absFRF),'LineWidth',LineWidth,'DisplayName',DisplayName,'Color',Color,'LineStyle',LineStyle)
        end
    end
    
end

obj.make_figure_title();
obj.make_amplitude_label(type,unit,amplitudeMeasure);
xlabel('$f$/Hz','Interpreter','latex')
legend('show')

end