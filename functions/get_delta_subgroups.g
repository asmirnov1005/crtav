return function (dimA, G, iota, representativesOfSubgroupsOfG, admissibleAutomorphismsOfG)
	local result;

	if Order(G) = 2 * dimA then
		return Filtered(representativesOfSubgroupsOfG, H -> Order(H) = 1);
	fi;

	result := Filtered(
		representativesOfSubgroupsOfG,
		H ->
			Order(H) = Order(G) / (2 * dimA) and
			not iota in H and
			not IsNormal(G, H)
	);
	if Length(result) > 1 then
		result := transformationsService.getGroupRepresentatives(result, admissibleAutomorphismsOfG);
	fi;

	return result;
end;