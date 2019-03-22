local CircularWordClass;

CircularWordClass := function (word)
  local getDualRepresentative, getWeight, isEqualTo, normalize, shift, shiftWord, splitWord;

  getDualRepresentative := function ()
    return List(word, function (s)
      if s = 'F' then
        return 'V';
      else
        return 'F';
      fi;
    end);
  end;

  getWeight := function ()
    local i,
          result;

    result := 0;
    for i in [1..Length(word)] do
      if word[i] = 'F' then
        result := result + 2^i;
      else
        result := result - 2^i;
      fi;
    od;

    return result;
  end;

  isEqualTo := function (circularWord)
    local representative, i;

    representative := circularWord.getRepresentative();
    if not Length(representative) = Length(word) then
      return false;
    fi;
    if representative = word then
      return true;
    fi;
    for i in [1..(Length(representative) - 1)] do
      representative := shift(representative);
      if representative = word then
        return true;
      fi;
    od;

    return false;
  end;

  normalize := function ()
    local i, weight, bestWeight, bestShiftIndex;

    bestWeight := getWeight();
    bestShiftIndex := 0;
    for i in [1..(Length(word) - 1)] do
      shiftWord();
      weight := getWeight();
      if weight < bestWeight then
        bestWeight := weight;
        bestShiftIndex := i;
      fi;
    od;
    shiftWord(bestShiftIndex + 1);
  end;

  shift := function (arg)
    local shiftedWord, shiftSize;

    shiftedWord := arg[1];
    if Length(arg) > 1 then
      shiftSize := arg[2];
    else
      shiftSize := 1;
    fi;

    if shiftSize mod Length(shiftedWord) = 0 then
      return shiftedWord;
    fi;

    return Concatenation(shiftedWord{[(shiftSize + 1)..Length(shiftedWord)]}, shiftedWord{[1..shiftSize]});
  end;

  shiftWord := function (arg)
    local shiftSize;

    if Length(arg) > 0 then
      shiftSize := arg[1];
    else
      shiftSize := 1;
    fi;

    word := shift(word, shiftSize);
  end;

  splitWord := function (d)
    local i,
          result;

    result := [];
    for i in [1..(Length(word) / d)] do
      Add(result, word{[((i - 1) * d + 1)..(i * d)]});
    od;

    return result;
  end;

  if IsEmpty(word) then
    Error("word should not be empty");
  fi;

  normalize();

  return rec(
    getDecomposition := function ()
      local divisorsOfWordLength, d, subwords;

      if (not 'F' in word) or (not 'V' in word) then
        return List(word, s -> CircularWordClass(word{[1]}));
      fi;
      divisorsOfWordLength := DivisorsInt(Length(word));
      for d in divisorsOfWordLength{[2..(Length(divisorsOfWordLength) - 1)]} do
        subwords := splitWord(d);
        if checkForEachPair(subwords) then
          return List(subwords, subword -> CircularWordClass(subword));
        fi;
      od;

      return [ CircularWordClass(word) ];
    end,
    getDual := function ()
      return CircularWordClass(getDualRepresentative());
    end,
    getDualRepresentative := function ()
      return getDualRepresentative();
    end,
    getRepresentative := function ()
      return word;
    end,
    getWeight := function ()
      return getWeight();
    end,
    isDualTo := function (circularWord)
      return isEqualTo(circularWord.getDual());
    end,
    isEqualTo := function (circularWord)
      return isEqualTo(circularWord);
    end,
    isLighterThan := function (circularWord)
      return getWeight() < circularWord.getWeight();
    end,
    isSelfDual := function ()
      return isEqualTo(CircularWordClass(word).getDual());
    end
  );
end;

return CircularWordClass;