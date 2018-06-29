classdef Geometry < handle
    properties
        name
        geometry
        material
    end
    
    methods
        function obj = Geometry(cnfg)
         if nargin == 0
           obj.geometry = [0];  
           obj.name = 'Geometrie eines Rotorsystems';
         else
           obj.name = cnfg.name;
           obj.material = cnfg.material;

           for k= 1:length(cnfg.geo_nodes)
               obj.geometry.nodes(k) = GeoNode(k,cnfg.geo_nodes{k}(1,1),cnfg.geo_nodes{k}(1,2));
           end
         end
        end
        
        function show_2D(obj)

            n_nodes = length(obj.geometry.nodes);
            f1 = figure;
            geo_node_z=zeros(1,n_nodes);
            geo_node_x=zeros(1,n_nodes);

            for k=1:n_nodes
                geo_node_z(k) = obj.geometry.nodes(k).z;
                geo_node_x(k) = obj.geometry.nodes(k).x;
                plot(geo_node_z, geo_node_x, 'k-o');
            end
           axis([min(geo_node_z)-1 max(geo_node_z)+1 min(geo_node_x)-1 max(geo_node_x)+1])
        end
        
        function show_3D(obj)
           a=1;
           n=1;
           dimR=size(obj.geometry.nodes);
           n_nodes = length(obj.geometry.nodes);
           r=zeros(n_nodes,1);
           geo_node_z=zeros(1,n_nodes);
           geo_node_x=zeros(1,n_nodes);
           
           f2=figure;
% erzeuge Vektor r mit Radien der Abschnitte
%==========================================================================
           for k=1:n_nodes
            
               
            for k=1:n_nodes
                geo_node_z(k) = obj.geometry.nodes(k).z;
                geo_node_x(k) = obj.geometry.nodes(k).x;
            end
            while n <n_nodes
    
                r(n,1)=geo_node_x(n);
    
                n=n+1;
    
            end

            if a < dimR(1)
                a=a+1;
            end

           end

%==========================================================================
           myaxes = axes('xlim', [-10 10], 'ylim', [-10 10], 'zlim',[-10 10]);

           view(3);
           grid on;
           axis equal;
           hold on
           xlabel('x')
           ylabel('y')
           zlabel('z')

           dim_r=size(r);
           theta = linspace(0,2*pi,20);

           k=1;
           %%%%%%%%%%%%%%%%%%%%%%%
           %erstes el
           rs = linspace(0,r(1),2);
           % 
           [TH,R] = meshgrid(theta,rs);
           % 
           Z=((R.*cos(TH)).^2)-((R.*sin(TH)).^2); % z=(x^2)-(y^2)
           % 
           [x,y,z] = pol2cart(TH,R,Z);
 
           z=z*0;

           hs(1)=surf(x,y,z+geo_node_z(1));
           set(hs(1), 'edgecolor','none')
           set(hs(1), 'facecolor','b')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


           for n=2:dim_r(1)

           %Berechnen der Zylinderelemente   
                [xzyl, yzyl, zzyl] = cylinder([r(n) r(n)]);

                [xZ1, yz1, zZ1] = cylinder([r(n) r(n)]);

                zzyl(1,:)=geo_node_z(n-1);
                zzyl(2,:)=geo_node_z(n);

           %% berechenen der Scheiben bzw Zyl. Deckel :-))
 
                rs = linspace(0,r(n),2);
% 
                [TH,R] = meshgrid(theta,rs);
% 
                Z=((R.*cos(TH)).^2)-((R.*sin(TH)).^2); % z=(x^2)-(y^2)
% 
                [x,y,z] = pol2cart(TH,R,Z);
 
                z=z*0;

                %plote Zylinder
                %hz(n) = surf(zzyl,yzyl, xzyl);
                hz(n) = surf(xzyl,yzyl, zzyl);
                set(hz(n), 'edgecolor','none')
                set(hz(n), 'facecolor','b')
                %Plote Deckel
                %hs(n)=surf(z+geo_node_x(n),y,x);
                hs(n)=surf(x,y,z+geo_node_z(n));
                set(hs(n), 'facecolor','b')

                if r(n) > r(n-1) 

                    set(hs(n), 'edgecolor','none') %sichtbare deckel ohne edges

                end

                if r(n) < r(n-1)
                    set(hs(n-1), 'edgecolor','none')   %sichtbare deckel ohne edges
                end
                
                k=k+2;

           end

           set(hs(n), 'edgecolor','none')
           set(hs(n), 'facecolor','b')


           zz=1:50;

           end

   end
        
end    