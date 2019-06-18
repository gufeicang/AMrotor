classdef Rotor < handle
   properties
      cnfg=struct([])
      
      name
      nodes
      matrizen
      
      moment_of_inertia
      
      sensors=AMrotorSIM.Sensors.Sensor().empty
      lager=AMrotorSIM.Bearings.Lager().empty
   end
   methods
       %Konstruktor
       function obj = Rotor(a)
         if nargin == 0
           obj.name = 'Default Rotor';
         else
           obj.cnfg = a;
           obj.name = obj.cnfg.name;
         end
       end
       
       function mesh(obj)
           disp('Mesh ....')
          [obj.nodes] = meshing(obj.cnfg);  %function divide rotor in thin disks 
       end
      
      function print(obj)
         disp(obj.name);
      end
      
      function [M,G,D,K] = compute_matrices(obj)
          disp('Compute Matrices Rotor')
        [obj.moment_of_inertia, volume] = compute_moment_of_inertia(obj.cnfg); %column_1 cross section area; column_2 I_xi; column_3 I_eta; column_4 I_p; column_5 PhiS
        disp('Volume')
        disp(volume)
        %massmatrix
        M  = compute_mass_matrix(obj.cnfg,obj.moment_of_inertia, obj.nodes);
        %stiffnesmatrix
        K  = compute_stiffness_matrix(obj.cnfg, obj.moment_of_inertia, obj.nodes);
        %gyroskopie
        G  = 2*compute_gyroscopic_matrix(obj.cnfg, obj.moment_of_inertia, obj.nodes);
        
        n_nodes = length(obj.nodes);

        %D=zeros(n_nodes*4, n_nodes*4);
        D=0.01*M+0.001*K;
        
        obj.matrizen.M=M;
        obj.matrizen.G=G;
        obj.matrizen.D=D;
        obj.matrizen.K=K;
      end   
   end
   
   methods
       [Jt,Dt,Kt] = compute_torsion_matrices(obj)
       
      function [diameter] = get_diameter(obj,pos)
          nr_of_rows = size(obj.cnfg.rotor_dimensions,1);
          j= 1;
           
           while j ~= nr_of_rows
                if pos >= obj.cnfg.rotor_dimensions(j,1) && pos < obj.cnfg.rotor_dimensions(j+1,1)
                    diameter = obj.cnfg.rotor_dimensions(j,2);
                    return
                else
                    j = j+1;
  
                end

           end
      end
   end
end