function [h] = Ergaenze_UnwuchtmasseCW(h,par,Parameter)

Knoten = par.Knoten;
 F1_Position =Parameter(1);
 Unwucht = Parameter(2);
 Winkellage = Parameter(3);
 
 Fx = cos(Winkellage)*Unwucht;
 Fy = sin(Winkellage)*Unwucht;
 
n=2;
while F1_Position > Knoten(n)
    n = n+1;
end

% Kraft greift an den Knoten n-1 und n an
nPos1 = n*2; %revelante Koordinaten: nPos1-3 bis nPos1 in v-Richtung
nPos2 = 2*length(Knoten) + n*2; % relevante Koordinaten: nPos2-3 bis nPos2 in w-Richtung

l_Ele = Knoten(n) - Knoten(n-1);
xi = (F1_Position - Knoten(n-1)) / l_Ele; % xi von 0 bis 1

% h = [B_V * Fx; B_W * Fy]
h.h_ZPcos(nPos1-3) = h.h_ZPcos(nPos1-3) + Fx * (1-3*xi^2+2*xi^3); %KRaftX
h.h_DBsin(nPos1-2) = h.h_DBsin(nPos1-2) + Fx * l_Ele*xi*(xi-1)^2; %Moment umY
h.h_ZPcos(nPos1-1) = h.h_ZPcos(nPos1-1) + Fx * xi^2*(3-2*xi);
h.h_DBsin(nPos1)   = h.h_DBsin(nPos1)   + Fx * l_Ele*xi^2*(xi-1);

h.h_ZPsin(nPos2-3) = h.h_ZPsin(nPos2-3) + Fy * (1-3*xi^2+2*xi^3);
h.h_DBcos(nPos2-2) = h.h_DBcos(nPos2-2) + Fy * (-l_Ele)*xi*(xi-1)^2;
h.h_ZPsin(nPos2-1) = h.h_ZPsin(nPos2-1) + Fy * xi^2*(3-2*xi);
h.h_DBcos(nPos2)   = h.h_DBcos(nPos2)   + Fy * (-l_Ele)*xi^2*(xi-1);

   

