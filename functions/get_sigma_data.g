return function (result, CMType, G, factorGByDeltaLeft, factorGByG0Left, admissibleAutomorphismsOfG)
  local TIMES_SYMBOL,
        constructKraftDiagram, getCircularWordsByKraftDiagram, getCountOfDoubleCosets, getDecompositionType, groupAndStringifyCircularWords,
        sigma, decompositionType, BT1GroupSchemes;

  TIMES_SYMBOL := '*';

  constructKraftDiagram := function (factorSet, markedClasses, sigma)
    local constructEdgesByFactorSet,
          edges, chain, i,
          result;

    constructEdgesByFactorSet := function ()
      local constructEdgeByClass,
            class,
            result;

      constructEdgeByClass := function (class)
        if class in markedClasses then
          return Edge(Set(class), Set(class * sigma), "V");
        else
          return Edge(Set(class * sigma), Set(class), "F");
        fi;
      end;

      result := [];
      for class in factorSet do
        Add(result, constructEdgeByClass(class));
      od;

      return result;
    end;

    result := [];
    edges := constructEdgesByFactorSet();
    while Length(edges) > 0 do
      chain := Chain();
      while not chain.isCycle() do
        for i in [1..Length(edges)] do
          if chain.addSymbolFromEdge(edges[i]) then
            Remove(edges, i);
            break;
          fi;
        od;
      od;
      Add(result, chain);
    od;

    return result;
  end;

  getCircularWordsByKraftDiagram := function (diagram)
    return Flat(List(diagram, chain -> CircularWord(chain.getWord()).getDecomposition()));
  end;

  getCountOfDoubleCosets := function (factorSet, group)
    return Length(constructFactorset(factorSet, group, function (elem, g)
      return elem * g;
    end));
  end;

  getDecompositionType := function (decompositionGroup)
    return Concatenation(
      "(",
      String(getCountOfDoubleCosets(factorGByDeltaLeft, decompositionGroup)),
      ", ",
      String(getCountOfDoubleCosets(factorGByG0Left, decompositionGroup)),
      ")"
    );
  end;

  groupAndStringifyCircularWords := function (circularWords)
    local addToResult, isEqual,
          alreadyTaken, circularWord, dualCircularWord, indexOfDualCircularWord,
          result;

    addToResult := function (circularWord, isSelfDual)
      if isSelfDual then
        Add(result, circularWord.getRepresentative());
      else
        Add(result, Concatenation(circularWord.getRepresentative(), [TIMES_SYMBOL], circularWord.getDualRepresentative()));
      fi;
    end;

    isEqual := function (circularWord1, circularWord2)
      return circularWord1.isEqualTo(circularWord2);
    end;

    result := [];
    alreadyTaken := [];
    for circularWord in circularWords do
      if circularWord.isSelfDual() then
        addToResult(circularWord, true);
      else
        dualCircularWord := circularWord.getDual();
        indexOfDualCircularWord := indexOf(alreadyTaken, dualCircularWord, isEqual);
        if not indexOfDualCircularWord = -1 then
          Remove(alreadyTaken, indexOfDualCircularWord);
          if dualCircularWord.isLighterThan(circularWord) then
            addToResult(circularWord, false);
          else
            addToResult(dualCircularWord, false);
          fi;
        else
          Add(alreadyTaken, circularWord);
        fi;
      fi;
    od;

    if Length(result) > 1 then
      Sort(result);
      result := List(result, function (circularWordRepresentation)
        if TIMES_SYMBOL in circularWordRepresentation then
          return Concatenation("(", circularWordRepresentation, ")");
        else
          return circularWordRepresentation;
        fi;
      end);
    fi;

    return result;
  end;

  for sigma in Elements(G) do
    decompositionType := getDecompositionType(Group(sigma));
    if not decompositionType in RecNames(result) then
      result.(decompositionType) := Set([]);
    fi;
    BT1GroupSchemes := groupAndStringifyCircularWords(
      getCircularWordsByKraftDiagram(
        constructKraftDiagram(factorGByDeltaLeft, CMType, sigma)
      )
    );
    AddSet(result.(decompositionType), JoinStringsWithSeparator(BT1GroupSchemes, [TIMES_SYMBOL]));
  od;;

  return result;
end;;