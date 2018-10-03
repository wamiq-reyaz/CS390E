function [ Aeq, beq, Aineq, bineq ] = genConstr( xx, yy, hh, ww, options)
% [ Aeq, beq, Aineq, bineq ] = genConstr( xx, yy, hh, ww , type) 
% generates the constraints for the type of system you want to solve
% Possible options are 
%1 'VBFHFW' Variable bottom. Others fixes
%2 'VBFHFWNO' Same as above but no overlap constraints
%3 'VBVHVWNO' Variable top and bottom, no overlap
%4 'VBVUFHFWTA' Varible top and bottom, top aligned
%5
    type = options.type;
    msize = options.rows;
    nsize = options.cols;
    
    EPS = 1E-3;

    switch type
        case 'VBFHFW'
            nConstr = (nsize - 2) * msize;
            Aeq = zeros(nConstr, length(xx));
            beq = zeros(nConstr, 1);

            constr = 1;
            for ii=1:msize
                for jj=1:(nsize-2)
                    base = (ii-1)*nsize + jj;
                    Aeq(constr, base) = 1;
                    Aeq(constr, base+1) = -2;
                    Aeq(constr, base+2) = 1;
                    constr = constr+1;
                end
            end
            
            Aineq = [];
            bineq = [];
            
        case 'VBFHFWNO'
            % Same equality constraints. Add inequality constraints
            nConstr = (nsize - 2) * msize;
            Aeq = zeros(nConstr, length(xx));
            beq = zeros(nConstr, 1);

            constr = 1;
            for ii=1:msize
                for jj=1:(nsize-2)
                    base = (ii-1)*nsize + jj;
                    Aeq(constr, base) = 1;
                    Aeq(constr, base+1) = -2;
                    Aeq(constr, base+2) = 1;
                    constr = constr+1;
                end
            end
            
            nConstr = (nsize -1)*msize;
            Aineq = zeros(nConstr, length(xx));
            bineq = zeros(nConstr, 1);

            constr = 1;
            for ii=1:msize
                for jj=1:(nsize-1)
                    base = (ii-1)*nsize + jj;
                    Aineq(constr, base) = 1;
                    Aineq(constr, base+1) = -1;
                    bineq(constr) = -ww-EPS;
                    constr = constr + 1;
                end
            end
            
        case 'VBVUFHFW'
            % The optimization variables are [xlower, xupper]
            
            % the factor of two is because of the xlower and xupper being
            % the optimzied variables
            nConstr = (nsize-2) * msize; 
            Aeq = zeros(nConstr, 2*length(xx));
            beq = zeros(nConstr, 1);

            constr = 1;
            for ii=1:msize
                for jj=1:(nsize-2)
                    base = (ii-1)*nsize + jj;
                    Aeq(constr, base) = 1;
                    Aeq(constr, base+1) = -2;
                    Aeq(constr, base+2) = 1;
                    constr = constr+1;
                end
            end
            
            nConstr = (nsize -1)*msize; 
            Aineq = zeros(nConstr, 2*length(xx));
            bineq = zeros(nConstr, 1);
            
            % just offset the entire thing by length(xx) because the ineq
            % constraints only apply to the upper variables
            constr = 1;
            for ii=1:msize
                for jj=1:(nsize-1)
                    base = (ii-1)*nsize + jj;
                    Aineq(constr, base) = 1;
                    Aineq(constr, base+length(xx)+1) = -1;
                    constr = constr + 1;
                end
            end
            
        case 'FBVUFHFWTA'
            % The optimization variables are [ylower, yupper]

            % the factor of two is because of the xlower and xupper being
            % the optimzied variables
            nConstr = (nsize-1) * msize; 
            Aeq = zeros(nConstr, length(yy));
            beq = zeros(nConstr, 1);

            constr = 1;
            for ii=1:msize
                for jj=1:(nsize-1)
                    base = (ii-1)*nsize + jj;
                    Aeq(constr, base) = 1;
                    Aeq(constr, base+1) = -1;
                    constr = constr+1;
                end
            end
            
            Aineq = [];
            bineq =[];
            
        case 'VBFUFHFWLA'
        % The optimization variables are [xlower, xupper]

        % the factor of two is because of the xlower and xupper being
        % the optimzied variables
        nConstr = (msize-1) * nsize; 
        Aeq = zeros(nConstr, length(yy));                                                                                                              
        beq = zeros(nConstr, 1);

        constr = 1;
        for ii=1:msize-1
            for jj=1:nsize
                base = (ii-1)*nsize + jj;
                other = base + nsize;
                Aeq(constr, base) = 1;
                Aeq(constr, other) = -1;
                constr = constr+1;
            end
        end

        Aineq = [];
        bineq =[];
        
        case 'ALL'
            
    
            
        otherwise
            error('Not implemented');
            yy;hh;ww;
    end
    


end

