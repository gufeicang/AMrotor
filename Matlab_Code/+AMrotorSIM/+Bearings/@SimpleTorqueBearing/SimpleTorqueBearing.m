classdef SimpleTorqueBearing < AMrotorSIM.Bearings.Bearing
   properties
       cnfg
   end
   methods
        function self=SimpleTorqueBearing(arg)
                        self = self@AMrotorSIM.Bearings.Bearing(arg);
            if nargin == 0
            self.name = 'Empty Bearing';
            else
            self.cnfg = arg;
            self.color = 'green'; 
            end

        end 
   end
end