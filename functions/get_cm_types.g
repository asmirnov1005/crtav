return function (orderOfG, iota, delta, factorGByDeltaLeft, representativesOfSubgroupsOfG, admissibleAutomorphismsOfG)
	local conjugateOfElement, isNotConjugatedPair, selectNonConjugatedCMTypes, selectPrimitiveCMTypes, selectNonEquivalentCMTypes,
        result;

	conjugateOfElement := function (class)
		return Set(List(class, element -> iota * element));
	end;

	isNotConjugatedPair := function (class1, class2)
		return not conjugateOfElement(class1) = class2;
	end;

	selectNonConjugatedCMTypes := function (allCMTypes)
		local i,
          result;

		result := Set([ allCMTypes[1] ]);
		for i in [2..Length(allCMTypes)] do
			if not Set(List(allCMTypes[i], element -> conjugateOfElement(element))) in result then
				AddSet(result, allCMTypes[i]);
			fi;
		od;

		return result;
	end;

	selectPrimitiveCMTypes := function (allCMTypes)
		local isPrimitive,
          i,
          result;

		result := Set([]);

		isPrimitive := function (CMType)
			local CMTypeRestriction, isCMType,
            allCMSubgroups,
            i;

			CMTypeRestriction := function (CMType, CMSubgroup)
				return Set(List(
					List(CMType, class -> class[1]),
					element -> Set(Elements(CMSubgroup) * element)
				));
			end;

			isCMType := function (preCMType, CMSubgroup)
				local i, j;

				if not Length(preCMType) = orderOfG / (2 * Order(CMSubgroup)) then
					return false;
				fi;

				for i in [1..Length(preCMType)-1] do
					for j in [i+1..Length(preCMType)] do
						if Set(preCMType[i]) = Set(iota * preCMType[j]) then
							return false;
						fi;
					od;
				od;

				return true;
			end;

			allCMSubgroups := Filtered(
				representativesOfSubgroupsOfG,
				function (H)
					return
						Order(H) > Order(delta) and
						IsSubgroup(H, delta) and
						not iota in H;
				end
			);

			for i in [1..Length(allCMSubgroups)] do
				if isCMType(CMTypeRestriction(CMType, allCMSubgroups[i]), allCMSubgroups[i]) then
					return true;
				fi;
			od;

			return false;
		end;

		for i in [1..Length(allCMTypes)] do
			if not isPrimitive(allCMTypes[i]) then
				AddSet(result, allCMTypes[i]);
			fi;
		od;

		return result;
	end;

	result := Set(List(Combinations(factorGByDeltaLeft, Length(factorGByDeltaLeft) / 2), l -> Set(l)));
	result := Filtered(result, CMType -> checkForEachPair(CMType, isNotConjugatedPair));;
	result := selectNonConjugatedCMTypes(result);
	result := selectPrimitiveCMTypes(result);
	if Length(result) = 0 then
		return Set([]);
	fi;
	if Length(result) > 1 then
		result := transformationsService.getCMTypeRepresentatives(result, admissibleAutomorphismsOfG);
	fi;

	return result;
end;;