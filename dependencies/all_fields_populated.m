function flag = all_fields_populated(dict)
    
    flag = all(structfun(@(x) all(size(x) == 1), table2struct(dict)));
    
end