 function transform_StateSpace_variant(obj)

    M=obj.systemmatrices.M; % Masse
    D=obj.systemmatrices.D; % D�mpfung
    G=obj.systemmatrices.G; % Gyroskopie
    K=obj.systemmatrices.K; % Steifigkeit
    h=obj.systemmatrices.h; % Lastvektor
    
    M_inv = M\eye(size(M));
        
    obj.systemmatrices.ss.A = sparse([zeros(length(M)),eye(length(M));-M_inv*K,-M_inv*D]);
    obj.systemmatrices.ss.AG = sparse([zeros(length(M)),zeros(length(M));zeros(length(M)),-M_inv*G]);
 
    obj.systemmatrices.ss.B= sparse([zeros(length(M)),zeros(length(M));zeros(length(M)),M_inv]);
    obj.systemmatrices.ss.C= sparse(eye(2*length(M)));
    obj.systemmatrices.ss.D=sparse(zeros(2*length(M)));
    %% Lastvektor in SS transformieren

        fields = fieldnames(h);
        for j=1:numel(fields)
            obj.systemmatrices.ss_h.(fields{j})=[zeros(size(M,1),1);M_inv*h.(fields{j})];
        end

 end