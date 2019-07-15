classdef Material < handle
% Material Class of material properties
    properties 
        name
        e_module        % Young's modulus
        G_module        % shear modulus
        density         % [kg/m^3]
        poisson         % shear_factor
        rayleigh_alpha1 % D = alpha_1*K + alpha_2*M
        rayleigh_alpha2 % D = alpha_1*K + alpha_2*M
    end
    
    methods
        function self = Material(cnfg)
            if nargin==0
                self.name = 'No Material configuration';
            else
                self.name = cnfg.name;
                self.e_module = cnfg.e_module;
                self.density = cnfg.density;
                self.poisson = cnfg.poisson;
                self.G_module = self.e_module/(2*(1+self.poisson));
                
                self.rayleigh_alpha1=cnfg.damping.rayleigh_alpha1;
                self.rayleigh_alpha2=cnfg.damping.rayleigh_alpha2;
            end
        end   
    end
end