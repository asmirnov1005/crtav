return function (G, admissibleAutomorphismsOfG)
	local result;
  
	result := Filtered(Elements(Centre(G)), g -> Order(g) = 2);
	if Length(result) > 1 then
		result := transformationsService.getElementRepresentatives(result, admissibleAutomorphismsOfG);
	fi;
  
	return result;
end;;