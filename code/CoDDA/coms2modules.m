function modules = coms2modules(coms)
CoDDA_uni = unique(coms);
numofcoms = length(CoDDA_uni);
modules = cell(1,numofcoms);
for i = 1:numofcoms
    module = find(coms == CoDDA_uni(i,1));
    modules{1,i} = module;
end

end