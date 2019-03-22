return function (dimA, dimensionFilter)
  local integerPart,
        result;

  integerPart := Int(dimensionFilter);
  if (integerPart = fail) then
    integerPart := Int(ReplacedString(dimensionFilter, "UpTo", ""));
    if (integerPart = fail) then
      result := false;
    else
      result := dimA > integerPart;
    fi;
  else
    result := not dimA = integerPart;
  fi;

  return result;
end;