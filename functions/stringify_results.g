return function (sigmaData)
  local resultStr,
        dimA, decompositionType, circularWord,
        results;

  results := [];
  for dimA in [1..Length(sigmaData)] do
    if (IsEmpty(RecNames(sigmaData[dimA]))) then
      continue;
    fi;
    resultStr := Concatenation("\nDim(A) = ", String(dimA), ":");
    for decompositionType in RecNames(sigmaData[dimA]) do
      resultStr := Concatenation(resultStr, "\n", settings.printing.indent, decompositionType, ":");
      for circularWord in sigmaData[dimA].(decompositionType) do
        resultStr := Concatenation(resultStr, "\n", settings.printing.indent, settings.printing.indent, circularWord);
      od;
    od;
    Add(results, resultStr);
  od;

  return Concatenation("\nResults:\n", JoinStringsWithSeparator(results, "\n"));
end;