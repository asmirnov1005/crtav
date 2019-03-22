return function (startTime, currentTime)
  local ACCURACY, SECOND,
        prettifyFloat;

  ACCURACY := 3;
  SECOND := 1000;

  prettifyFloat := function (x, n)
    local floatParts;

    floatParts := SplitString(String(Float(x)), ".");
    return Concatenation(floatParts[1], ".", floatParts[2]{[1..Minimum(n, Length(floatParts[2]))]});
  end;

  return Concatenation("Calculation duration: ", prettifyFloat((currentTime - startTime) / SECOND, ACCURACY), " sec.");
end;