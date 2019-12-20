classdef Velocitysensor < AMrotorSIM.Sensors.Sensor
% Velocitysensor Class of sensors for reading the velocity values after
% time integration
   properties
       unit = 'm/s'
       Position
       measurementType = 'Velocity'  
   end
   methods
        function self=Velocitysensor(config) 
           self = self@AMrotorSIM.Sensors.Sensor(config);
           self.Position = config.position;
        end 
   end
end


