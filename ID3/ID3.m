function node = ID3(examples, target_set, attributes)
  
   n_positive = nnz(examples(:, target_set) == 1);
   n_negative = size(examples,1)-n_positive;
   
   if(size(examples(:, target_set), 1) == n_positive)
       
       node = struct('is_leaf_node', true, 'data', 'yes', 'label', '', 'n_children', 0, 'children', struct([]));
        
       return
   end
   if(size(examples(:, target_set), 1) == n_negative)
        
       node = struct('is_leaf_node', true, 'data', 'no', 'label', '', 'n_children', 0,'children', struct([]));
         
       return
   end
   
   A = calcEntropy(examples, attributes, target_set);
   node.data = A;
   node.children = struct([]);   
   node.is_leaf_node = false;
   node.n_children = 0;
   node.label = 0;
   
   
   values = unique(examples(:, A));
   
   for x = 1:size(values, 1)    
    %add a new branch
    
    value = values(x, 1);
    examples_with_values = examples(examples(:, A)== value,:);
    
    if(size(examples_with_values, 1) == 0)
         
        if(mode(examples_with_values(:, target_set)) == 1)
            node = struct('is_leaf_node', true, 'data', 'yes','label', value, 'n_children', 0, 'children', struct([]));
        else
            node = struct('is_leaf_node', true, 'data', 'no', 'label', value,'n_children', 0, 'children', struct([]));
        end
        
        node.children = [node.children; leaf_node];
        
    else
        
        result = ID3(examples_with_values, target_set, setdiff(attributes, A));
        node.n_children =  node.n_children + 1;
        result.label = value;
        node.children = [node.children; result];
        
    end  
   
   end
end