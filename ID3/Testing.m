function accuracy = Testing(testcases, tree)

n_rows=size(testcases, 1);
n_pos=0;

for inx=1:n_rows
current_node = tree(1);

while(~current_node.is_leaf_node)
    
    child_nodes = current_node.children;
    
    for iny = 1:current_node.n_children
       if(child_nodes(iny).label == testcases(inx, current_node.data))
           current_node = child_nodes(iny);
           break;
       end
    end
    
    if(iny == current_node.n_children)
        result = 'no'; %#ok<NASGU>
        break;
    end
    
      
end
result = current_node.data;
if(((strcmp(result, 'yes') && testcases(inx, 5) == 1) || (strcmp(result, 'no') && testcases(inx, 5) ~= 1)))
    n_pos = n_pos + 1;
end
end
   accuracy = n_pos / n_rows;
end