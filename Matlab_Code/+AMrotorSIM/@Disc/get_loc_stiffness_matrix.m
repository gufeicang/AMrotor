function [K] = get_loc_stiffness_matrix(self)
            
    K=sparse(6,6);
    
    % dof-order: ux,uy,uz,psix,psiy,psiz
    
            
    self.stiffness_matrix = K;
end