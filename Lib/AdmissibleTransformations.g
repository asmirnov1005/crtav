Read("/crtav/Lib/Helpers.g");;

FilterTransformationsFixingSet := function (S, Transformations)
	local filteredTransformations, i;
	filteredTransformations := [];
	for i in [1..Length(Transformations)] do
		if Set(Image(Transformations[i], S)) = S then
			Add(filteredTransformations, Transformations[i]);
		fi;
	od;
	return filteredTransformations;
end;;

FilterTransformationsFixingElement := function (Element, Transformations)
	return Stabilizer(ToGroup(Transformations), Element);
end;;

FilterTransformationsFixingSubgroup := function (Subgroup, Transformations)
	return Stabilizer(ToGroup(Transformations), Set(Elements(Subgroup)), OnSets);
end;;

SetCanBeAdmissibleTransformed := function (S, NonEquivSets, AdmTransformations)
	local i, T;
	for i in [1..Length(AdmTransformations)] do
		T := AdmTransformations[i];
		if Set(Image(T, S)) in NonEquivSets then
			return true;
		fi;
	od;
	return false;
end;;

SelectNonEquivalentSets := function (EquivSets, AdmTransformations)
	local nonEquivSets, i;
	nonEquivSets := Set([]);
	AddSet(nonEquivSets, Set(EquivSets[1]));
	for i in [2..Length(EquivSets)] do
		if not SetCanBeAdmissibleTransformed(EquivSets[i], nonEquivSets, AdmTransformations) then
			AddSet(nonEquivSets, EquivSets[i]);
		fi;
	od;
	return nonEquivSets;
end;;

SelectNonEquivalentElements := function (EquivElements, AdmTransformations)
	local nonEquivElements, orbitOfElement, i;
	nonEquivElements := Set([]);
	AddSet(nonEquivElements, EquivElements[1]);
	for i in [2..Length(EquivElements)] do
		orbitOfElement := Orbit(ToGroup(AdmTransformations), EquivElements[i]);
		if First(nonEquivElements, element -> element in orbitOfElement) = fail then
			AddSet(nonEquivElements, EquivElements[i]);
		fi;
	od;
	return nonEquivElements;
end;;

SelectNonEquivalentGroups := function (EquivGroups, AdmTransformations)
	local nonEquivGroups, orbitOfGroup, i;
	if Length(EquivGroups) = 0 then
		return [];
	fi;
	nonEquivGroups := Set([]);
	AddSet(nonEquivGroups, EquivGroups[1]);
	for i in [2..Length(EquivGroups)] do
		orbitOfGroup := Orbit(ToGroup(AdmTransformations), Set(Elements(EquivGroups[i])), OnSets);
		if First(nonEquivGroups, group -> Set(Elements(group)) in orbitOfGroup) = fail then
			AddSet(nonEquivGroups, EquivGroups[i]);
		fi;
	od;
	return nonEquivGroups;
end;;