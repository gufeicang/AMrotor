classdef AngularVelocitysensor < AMrotorSIM.Sensors.Sensor
% Velocitysensor Class of sensors for reading the velocity values after
% time integration
   properties
       unit = 'rad/s'
       Position
       measurementType = 'AngularVelocity'  
   end
   methods
        function self=AngularVelocitysensor(config) 
           self = self@AMrotorSIM.Sensors.Sensor(config);
           self.Position = config.position;
        end 
   end
end


