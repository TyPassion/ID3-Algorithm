function [ A ] = calcEntropy( examples, attributes, target_attribute)

    n_examples = size(examples, 1);
    n_attributes = size(attributes, 2);
    
    
    n_positive = nnz(examples(:, target_attribute) == 1);
    n_negitive = size(examples, 1) - n_positive;
    
    S = -(( (n_positive / n_examples) * log2(n_positive / n_examples)) + ((n_negitive / n_examples) * log2(n_negitive / n_examples)));
  
    information_gain = [];
        
    for x = 1:n_attributes
        
        attribute = attributes(1, x);
        
        values_entropy = 0.0;
                      
        values = unique(examples(:, attribute));
        
            for value = 1:size(values, 1)
                
                examples_with_values = examples(examples(:,attribute)== value,:);
                
                n_value_examples  = size( examples_with_values, 1);
                
                n_pos_examples = size( examples_with_values(examples_with_values(:,end)== 1,:), 1);
                
                n_neg_examples =  n_value_examples - n_pos_examples;
                
                if(n_value_examples > 0)
                
                    if(n_pos_examples ~=0 && n_neg_examples == 0)

                        values_entropy = values_entropy + ((n_value_examples/n_examples) * ((n_pos_examples/n_value_examples) * log2((n_pos_examples/n_value_examples))));

                    elseif(n_pos_examples ==0 && n_neg_examples ~= 0)

                          values_entropy = values_entropy + ((n_value_examples/n_examples) * ((n_neg_examples/n_value_examples) * log2((n_neg_examples/n_value_examples))));


                    elseif(n_pos_examples ~=0 && n_neg_examples ~= 0)

                           values_entropy = values_entropy + ((n_value_examples/n_examples) * ((n_pos_examples/n_value_examples) * log2((n_pos_examples/n_value_examples)) + (n_neg_examples/n_value_examples) * log2((n_neg_examples/n_value_examples))));
                  
                    end                
                end
            end 
            
          information_gain = [information_gain (S - abs(values_entropy))];
          
    end   
          [M,I] = max(information_gain);
          A = attributes(1, I);
end

