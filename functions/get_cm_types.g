return function (G, iota, delta, factorGByDeltaLeft, subgroupsOfG, admissibleAutomorphismsOfG)
  local conjugateOfElement, isNotConjugatedPair, generateCMTypes, selectNonConjugatedCMTypes, selectPrimitiveCMTypes,
        result;

  conjugateOfElement := function (class)
    return Set(List(class, element -> iota * element));
  end;

  isNotConjugatedPair := function (class1, class2)
    return not conjugateOfElement(class1) = class2;
  end;

  generateCMTypes := function ()
    local initConjugatedPairs,
          conjugatedPairs,
          result;

    initConjugatedPairs := function ()
      local class, classIndex,
            result;

      result := [];
      for class in factorGByDeltaLeft do
        classIndex := indexOf(result, class, function (resultClasses, currentClass)
          return conjugateOfElement(resultClasses[1]) = currentClass;
        end);
        if classIndex = -1 then
          Add(result, [class]);
        else
          Add(result[classIndex], class);
        fi;
      od;

      return result;
    end;

    # First way for the calculating of CM types.
    if true then
      result := Set(List(Combinations(factorGByDeltaLeft, Length(factorGByDeltaLeft) / 2), l -> Set(l)));
      result := Filtered(result, CMType -> checkForEachPair(CMType, isNotConjugatedPair));
    else
      conjugatedPairs := initConjugatedPairs();
      result := Set(List(Tuples([1, 2], Length(conjugatedPairs)), tuple -> Set(List([1..Length(tuple)], i -> conjugatedPairs[i][tuple[i]]))));
    fi;

    return result;
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
    local getCMSubgroups, isPrimitive,
          allCMSubgroups, i,
          result;

    getCMSubgroups := function ()
      local invariantFilter, getSuitableRepresentative;

      invariantFilter := function (H)
        return Order(H) > Order(delta) and not iota in H;
      end;

      getSuitableRepresentative := function (H)
        return First(ConjugateSubgroups(G, H), K -> IsSubgroup(K, delta));
      end;

      return Filtered(List(Filtered(subgroupsOfG, invariantFilter), getSuitableRepresentative), IsGroup);
    end;

    isPrimitive := function (CMType)
      local CMTypeRestriction, isCMType,
            i;

      CMTypeRestriction := function (CMType, CMSubgroup)
        return Set(List(
          List(CMType, class -> class[1]),
          element -> Set(Elements(CMSubgroup) * element)
        ));
      end;

      isCMType := function (preCMType, CMSubgroup)
        local i, j;

        if not Length(preCMType) = Order(G) / (2 * Order(CMSubgroup)) then
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

      for i in [1..Length(allCMSubgroups)] do
        if isCMType(CMTypeRestriction(CMType, allCMSubgroups[i]), allCMSubgroups[i]) then
          return true;
        fi;
      od;

      return false;
    end;

    allCMSubgroups := getCMSubgroups();
    result := Set([]);

    for i in [1..Length(allCMTypes)] do
      if not isPrimitive(allCMTypes[i]) then
        AddSet(result, allCMTypes[i]);
      fi;
    od;

    return result;
  end;

  result := generateCMTypes();
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