return rec(
  filterByElement := function (element, transformationsGroup)
    return Stabilizer(transformationsGroup, element);
  end,

  filterBySubgroup := function (subgroup, transformationsGroup)
    return Stabilizer(transformationsGroup, Set(Elements(subgroup)), OnSets);
  end,

  filterByCMType := function (CMType, transformationsGroup)
    return Group(Filtered(Elements(transformationsGroup), function (transformation)
      return CMType = Set(List(CMType, class -> ImagesSet(transformation, class)));
    end));
  end,

  getElementRepresentatives := function (allElements, transformationsGroup)
    local orbitOfElement,
          i,
          result;

    result := Set([]);
    AddSet(result, allElements[1]);
    for i in [2..Length(allElements)] do
      orbitOfElement := Orbit(transformationsGroup, allElements[i]);
      if First(result, element -> element in orbitOfElement) = fail then
        AddSet(result, allElements[i]);
      fi;
    od;

    return result;
  end,

  getGroupRepresentatives := function (allGroups, transformationsGroup)
    local orbitOfGroup,
          i,
          result;

    if Length(allGroups) = 0 then
      return [];
    fi;
    result := Set([]);
    AddSet(result, allGroups[1]);
    for i in [2..Length(allGroups)] do
      orbitOfGroup := Orbit(transformationsGroup, Set(Elements(allGroups[i])), OnSets);
      if First(result, group -> Set(Elements(group)) in orbitOfGroup) = fail then
        AddSet(result, allGroups[i]);
      fi;
    od;

    return result;
  end,

	getCMTypeRepresentatives := function (allCMTypes, transformationsGroup)
		local constructSMTypeOrbit,
          i,
          result;

		constructSMTypeOrbit := function (CMType)
			return Set(List(
				Elements(transformationsGroup),
				automorphism -> Set(List(
					CMType,
					element -> Set(Image(automorphism, element))
				))
			));
		end;

		result := Set([ rec(
			CMType := allCMTypes[1],
			CMTypeOrbit := constructSMTypeOrbit(allCMTypes[1])
		) ]);

		for i in [2..Length(allCMTypes)] do
			if First(result, CMTypeData -> allCMTypes[i] in CMTypeData.CMTypeOrbit) = fail then
				AddSet(result, rec(
					CMType := allCMTypes[i],
					CMTypeOrbit := constructSMTypeOrbit(allCMTypes[i])
				));
			fi;
		od;

		return Set(List(result, CMTypeData -> CMTypeData.CMType));
	end
);