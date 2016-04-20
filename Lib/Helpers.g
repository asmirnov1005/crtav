CloneRec := function (record)
	local i, clone;
	clone := rec();
	for i in [1..Length(RecNames(record))] do
		clone.(RecNames(record)[i]) := record.(RecNames(record)[i]);
	od;
	return clone;
end;;

CloneList := function (list)
	local i, clone;
	clone := [];
	for i in [1..Length(list)] do
		Add(clone, list[i]);
	od;
	return clone;
end;;

ToGroup := function (elements)
	if IsGroup(elements) then
		return elements;
	else
		return Group(elements);
	fi;
end;;

GroupToList := function (group)
	if IsGroup(group) then
		return Elements(group);
	else
		return group;
	fi;
end;;

IsTrivialHomomorphism := function (f)
	return IsGroupHomomorphism(f) and Order(Image(f)) = 1;
end;;

CompositumProductOfLists := function (list1, list2)
	local i, j, list;
	list := [];
	for i in [1..Length(list1)] do
		for j in [1..Length(list2)] do
			Add(list, list1[i] * list2[j]);
		od;
	od;
	return list;
end;;

CompositumOfGroups := function (G1, G2)
	return Group(CompositumProductOfLists(Elements(G1), Elements(G2)));
end;;

IsIsomorphicGroups := function (G1, G2)
	return not IsomorphismGroups(G1, G2 : findall := false) = fail;
end;;

AllNonConjugatedSubgroups := function (G)
	return List(ConjugacyClassesSubgroups(G), Representative);
end;;

FactorsetOfGroupBySubgroup := function (arg)
	local group, subgroup, side;
	group := arg[1];
	subgroup := arg[2];
	side := "left";
	if Length(arg) > 2 then
		if arg[3] = "right" then
			side := "right";
		fi;
	fi;
	return Set(List(
		Elements(group),
		function (g)
			if side = "left" then
				return Set(Elements(subgroup) * g);
			else
				return Set(g * Elements(subgroup));
			fi;
		end
	));
end;;

ForAnyPair := function (S, Condition)
	local i, j;
	if Length(S) = 0 then
		return true;
	fi;
	for i in [1..Length(S)] do
		for j in [i..Length(S)] do
			if not Condition(S[i], S[j]) then
				return false;
			fi;
		od;
	od;
	return true;
end;;

PairwiseEqual := function (S)
	local EqualityCondition;
	EqualityCondition := function (element1, element2)
		return element1 = element2;
	end;
	return ForAnyPair(S, EqualityCondition);
end;;

SplitStringToEqualPartsOfGivingLength := function (splittedString, partLength)
	local i, strings, part;
	strings := [];
	if not Length(splittedString) mod partLength = 0 then
		return fail;
	fi;
	while Length(splittedString) > 0 do
		Add(strings, splittedString{[1..partLength]});
		splittedString := splittedString{[partLength+1..Length(splittedString)]};
	od;
	return strings;
end;;