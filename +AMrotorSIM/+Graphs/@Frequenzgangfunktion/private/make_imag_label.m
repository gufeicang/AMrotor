function label = make_imag_label(obj,type,unit)
% Assembles the label for the imaginary part of the FRF
%
%    :param type: Type of the FRF ('d' for displacement,....)
%    :type type: char
%    :param unit: Unit of the FRF
%    :type unit: char
%    :return: Labels for the imaginary part plot

% Licensed under GPL-3.0-or-later, check attached LICENSE file

HStr = ['Im(G_{',type,'})'];

unitStr = unit;
    

label = ['$',HStr,') \big/ \big(\mathrm{',unitStr,'}\big)$'];
ylabel(label,'Interpreter','latex')
end