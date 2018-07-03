function assemble_system_matrices(self)
    
%% Rotormatrizen aus FEM erstellen
            self.rotor.assemble_fem
            n_nodes=length(self.rotor.mesh.nodes);

            %Lokalisierungsmatrix hat 6x6n 0 Eintr�ge
            %Element L wird dann an der Stelle (i-1)*6 drauf addiert.

%% Lagermatrizen aufaddieren

            M_bearing=sparse(6*n_nodes,6*n_nodes);
            i=0;
            for bearing = self.bearings
                
                bearing.create_ele_loc_matrix
                bearing.get_loc_damping_matrix
                bearing.get_loc_mass_matrix
                bearing.get_loc_stiffness_matrix
                
                i=i+1;
                L_ele = sparse(6,6*n_nodes);
                L_ele(1:6,(i-1)*6+1:(i-1)*6+6)=bearing.localisation_matrix;

                M_bearing=M_bearing+L_ele'*bearing.mass_matrix*L_ele;
            end
        
%% Gesamtmatrizen addieren
        self.systemmatrices.M = self.rotor.matrices.M + M_bearing;
        
      
end