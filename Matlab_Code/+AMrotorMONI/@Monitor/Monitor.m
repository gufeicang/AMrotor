classdef Monitor < handle
   properties
       cnfg=struct([])
       name
   end
   methods
       function obj=Monitor(a)
         if nargin == 0
           obj.name = "Monitoring";
         else
           obj.name = a;
         end
       end
   
   end
end