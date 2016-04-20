Read("/crtav/Lib/AdmissibleTransformations.g");;

SelectDeltaSubgroups := function (mainData)
	local deltaSubgroups;
	if mainData.orderG = 2 * mainData.dimA then
		return Filtered(mainData.subgroupsRepresentatives, H -> Order(H) = 1);
	fi;
	deltaSubgroups := Filtered(
		mainData.subgroupsRepresentatives,
		H ->
			Order(H) = mainData.orderG / (2 * mainData.dimA) and
			not mainData.iota in H and
			not IsNormal(mainData.G, H)
	);
	if Length(deltaSubgroups) > 1 then
		deltaSubgroups := SelectNonEquivalentGroups(deltaSubgroups, mainData.allAutG.top());
	fi;
	return deltaSubgroups;
end;;