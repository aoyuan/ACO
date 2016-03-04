function model=BACO_setup()
    value  = [391 444 250 330 246 400 150 266 268 293 471 388 364 493 202 161 410 270 384 486];    
    weight = [55  52  59  24   52  46  45  34  34  59  59  28  57  21  47  66  64  42  22  23];    
    dim=numel(value);    
    capacity=500;
    
    model.dim=dim;
    model.value=value;
    model.weight=weight;
    model.capacity=capacity;
end