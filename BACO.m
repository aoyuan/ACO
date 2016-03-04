clc;clear all;close all
% % ===================================================================== %
% % Ant Conlony Optimization for Binary Knapsack Problem(demo)            %
% % ===================================================================== %
% % Author: aoyuan                                                        %
% % Release Date: November 9, 2015.                                       %
% % Modified Date:                                                        %
% % ===================================================================== %
% % ===================================================================== %
help BACO.m

%% Problem Definition
model=BACO_setup();

%% BACO Parameters
para = struct;
para.NGen=300;        % Maximum Number of Iterations
para.nAnt=40;         % Number of Ants (Population Size)
para.Q=1;
para.tau0=0.1;        % Initial Phromone
para.alpha=1;         % Phromone Exponential Weight
para.beta=0.02;       % Heuristic Exponential Weight
para.rho=0.1;         % Evaporation Rate

%% Main function
Nr = 10; 
for r = 1:Nr    
    rand('seed', sum(100 * clock)); 
    [BestCost,BeatAntSolIsFeasible,best_ant] = BACO_func('BACO_obj',model,para);   
    % Show Optimization Information
    if BeatAntSolIsFeasible(end)
        FeasiblityFlag = '*';
    else
        FeasiblityFlag = '';
    end
    disp(['R' num2str(r) ': Best Cost = ' num2str(BestCost(end)) ' ' FeasiblityFlag]);
end

