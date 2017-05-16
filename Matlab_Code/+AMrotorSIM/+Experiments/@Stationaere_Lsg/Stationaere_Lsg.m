classdef Stationaere_Lsg < handle
   properties
      name='Station�re L�sung'
      rotorsystem
      drehzahl
      time        % time steps [S]
      
      result
   end
   methods
       %Konstruktor
       function obj = Stationaere_Lsg(a,drehzahl,time)
         if nargin == 0
           disp('Keine L�sung m�glich ohne Rotorsystem')
         else
           obj.rotorsystem = a;
           obj.drehzahl = drehzahl;
           obj.time = time;
         end
       end
      
      function show(obj)
         disp(obj.name);
      end
      
      function compute(obj)
          disp('Compute.... ode15 ....')
        obj.rotorsystem.clear_time_result()  

        method = 0;             %% 0 == station�r;  1 == instation�r
        omega = obj.drehzahl*pi/60;           
        domega = 0;                         %domega_ode  [rad/s^2]
        
        M = obj.rotorsystem.systemmatrizen.M;
        G = obj.rotorsystem.systemmatrizen.G;
        D = obj.rotorsystem.systemmatrizen.D;
        K = obj.rotorsystem.systemmatrizen.K;
        h = obj.rotorsystem.systemmatrizen.h;

        EVmr = obj.rotorsystem.reduktionsmatrizen.EVmr;
        
        Z0 = cumpute_Z0_rotor(M,0, omega,domega,method); %init vector
        % solver parameters
        omega_rot_const_force = 0;     %[1/s] angular velocity of constant_rotating_force 
        options = odeset('AbsTol', 1e-6, 'RelTol', 1e-6); %'OutputFcn','odeprint' as option to display steps
        if (exist('verbose','var'))
            if verbose == 1
            options = odeset('OutputFcn','odeprint', 'OutputSel',1);
            end
        end
        
        % ODE function

        [obj.result.T,Z] = ode15s(@rotor_sys_function,obj.time,Z0,options,K,M,D,G,h,omega_rot_const_force,method);
        
        [obj.result.X,obj.result.X_d,x,x_d,beta,beta_d,y,y_d,alpha,alpha_d,omega_ode,phi_ode] = modal_back_transformation(Z,M,EVmr);
        
        obj.rotorsystem.time_result = obj.result;
      end
      
      function compute_newmark(obj)
        disp('Compute.... newmark ....')
        obj.rotorsystem.clear_time_result() 
        
        M = obj.rotorsystem.systemmatrizen.M;
        D = obj.rotorsystem.systemmatrizen.G+obj.rotorsystem.systemmatrizen.D;
        K = obj.rotorsystem.systemmatrizen.K;
        
        h = obj.rotorsystem.systemmatrizen.h;
        % Berechnung von Lastvektor f�r jeden Zeitschritt:
        t=obj.time;
        
        q_0=0.0;
        qd_0=0.0;
        qdd_0=0.0;
        
        beta=0.25;
        gamma=0.5;
        
        constant = 1;
        
        [q,qd,qdd] = newmark_integration( beta , gamma, M, D, K,f,t,q_0,qd_0,qdd_0,constant);
        
        obj.rotorsystem.time_result = obj.result;
      end
 
   end
   methods(Access=private)
       
   end
end