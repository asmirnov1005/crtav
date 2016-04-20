ConstructPermuatationGroupsRepresentatives := function (mainData)
	return List(
		ConjugacyClassesSubgroups(SymmetricGroup(2 * mainData.dimA)), 
		Representative
	);
end;;

ConvertToPermutationGroup := function (mainData)
	return First(
		mainData.permutationGroupsRepresentatives,
		H -> not IsomorphismGroups(H, mainData.G) = fail
	);
end;;