% Licensed under GPL-3.0-or-later, check attached LICENSE file

function plot_deltas( ax,x,y,color )
% Plots the deltas in the diagram ??????????
%
%    :parameter ax: Axes properties control of the figure
%    :type ax: matlab.graphics.axis.Axes object
%    :parameter x: ??????????
%    :type x: ??????????
%    :parameter y: ?????????
%    :type y: ????????????
%    :parameter color: Color
%    :type color: ???????????
%    :return: Curves of the deltas ????????????

    plot(ax,x,-real(y),...
              'Color',color)

end

