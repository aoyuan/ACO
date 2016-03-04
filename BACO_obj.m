function [cost, sol_isFeasible]=BACO_obj(x,model)
    value=model.value;
    weight=model.weight;
    capacity=model.capacity;

    W1=sum(weight.*x);
    V0=sum(value.*(1-x));
    
    Violation=max(W1/capacity-1,0);
    
    cost=V0*(1+100*Violation);
    sol_isFeasible=(Violation==0);
end