function set_material( self )
% set_material ist eine Methode der klasse MagneticBearing
% Zuweisen der Koeffizienten zu den Fl�chen der Lagergeometrie
% alle ben�tigten Informationen wurden in self.cnfg hinterlegt.
% Benoetigte Toolbox: PDE

% Koeffizienten fuer Luftphase
specifyCoefficients(self.model,'m',0,'d',0,'c',1/(self.cnfg.material.mu_Luft),'a',0,'f',0,'Face',self.cnfg.faces.Luft);         

% Koeffezienten der Eisenphase / Unterscheidung: nichtlinear oder lineares Model
if self.cnfg.material.nonlinMu  
    % For 2-D systems, c is a tensor with 4N� elements. ==> 4x4
    % Matlab interpretiert Skalare als x*eye(Passende Gr��e), Vektoren als
    % diag(...) und mehr.
    % Koeffizienten sind eine Funktion der L�sung
    cCoef = @(region,state)  ((self.cnfg.material.mu_0*...
        (self.cnfg.material.mu_rEisen./... 
        (1+0.05*(state.ux.^2 +state.uy.^2))+200)))^(-1);    % nicht konstanter Koeffizient C (Permeabilitaet)
                                                      %� = 4*pi*10^(-7)*(5000./(1+0.05*(ux.^2+uy.^2))+200) 
                                                      %^(-1) fehlte!
    specifyCoefficients(self.model,'m',0,'d',0,'c',cCoef,...
        'a',0,'f',0,'Face',self.cnfg.faces.Eisen);       % Eisenkern und Rotorbuechse

else 
      specifyCoefficients(self.model,'m',0,'d',0,'c',1/(self.cnfg.material.mu_Eisen),...
        'a',0,'f',0,'Face',self.cnfg.faces.Eisen);       % Eisenkern und Rotorbuechse


end

% Koeffizienten der Kupferspulen
specifyCoefficients(self.model,'m',0,'d',0,'c',1/(self.cnfg.material.mu_Kupfer),'a',0,'f',0,'Face',[self.cnfg.faces.SpuleA_1,self.cnfg.faces.SpuleB_1,self.cnfg.faces.SpuleA_2,self.cnfg.faces.SpuleB_2,self.cnfg.faces.SpuleA_3,self.cnfg.faces.SpuleB_3,self.cnfg.faces.SpuleA_4,self.cnfg.faces.SpuleB_4]);  

end
