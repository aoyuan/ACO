function [BestCost,BeatAntSolIsFeasible,best_ant] = BACO_func(fhd,mod,param)
    format short e
    
    % Model data
    dim = mod.dim;
    value = mod.value;
    weight = mod.weight;
    capacity = mod.capacity;
        
    % BACO Parameters
    NGen = param.NGen;         % Maximum Number of Iterations     
    nAnt = param.nAnt;         % Number of Ants (Population Size)
    Q = param.Q;
    tau0 = param.tau0;          % Initial Phromone
    alpha = param.alpha;        % Phromone Exponential Weight
    beta = param.beta;          % Heuristic Exponential Weight
    rho = param.rho;            % Evaporation Rate
 
    %% Initialization
    N = [0 1];
    eta=[weight./value value./weight];     % Heuristic Information
    tau=tau0*ones(2,dim);                  % Phromone Matrix
    BestCost=[];            % Array to Hold Best Cost Values
    
    ant_tour = zeros(nAnt,dim);
    ant_x = zeros(nAnt,dim);
    ant_cost = zeros(nAnt,1);
    ant_sol_isFeasible = zeros(nAnt,1);
   
    best_ant = zeros(1,dim);
    best_cost = inf;
    best_ant_sol_isFeasible = 0;
    
    BestCost = [];
    BeatAntSolIsFeasible = [];
    
    %% ACO Main Loop
    for it=1:NGen    
        % Move Ants
        for k=1:nAnt               
            for m=1:dim
                P=tau(:,m).^alpha.*eta(:,m).^beta;
                P=P/sum(P);
                j=RouletteWheelSelection(P);
                ant_tour(k,m) = j;
            end
            ant_x(k,:)=N(ant_tour(k,:));   
            [ant_cost(k), ant_sol_isFeasible(k)] = feval(fhd,ant_x(k,:),mod);
            if ant_cost(k)<best_cost
                best_cost = ant_cost(k);
                best_ant=ant_x(k,:);
                best_ant_sol_isFeasible = ant_sol_isFeasible(k);
            end       
        end
        % Update Phromones
        for k=1:nAnt
            tour=ant_tour(k,:);       
            for m=1:dim            
                tau(tour(m),m)=tau(tour(m),m)+Q/ant_cost(k);
            end        
        end    
        % Evaporation
        tau=(1-rho)*tau;
        % Store Best Cost
        BestCost=[BestCost best_cost];
        BeatAntSolIsFeasible =[BeatAntSolIsFeasible best_ant_sol_isFeasible];
    end    
end
