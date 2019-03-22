return function (sigmaData, testData)
  local getMessageForFailedTest,
        resultStr, dimA, decompositionType, sigmaDTypes, testDTypes, sigmaWords, testWords,
        results;

  getMessageForFailedTest := function (expectedValuesArray, gotValuesArray)
    return Concatenation(
      " is failed: expected {",
      JoinStringsWithSeparator(expectedValuesArray, ", "),
      "}, got {",
      JoinStringsWithSeparator(gotValuesArray, ", "),
      "}."
    );
  end;

  results := [];
  for dimA in [1..Length(sigmaData)] do
    if (IsEmpty(RecNames(sigmaData[dimA]))) then
      continue;
    fi;
    resultStr := Concatenation("\nDim(A) = ", String(dimA), ":");
    sigmaDTypes := RecNames(sigmaData[dimA]);
    testDTypes := RecNames(testData[dimA]);
    resultStr := Concatenation(resultStr, "\nTest 'Exhaustion'");
    if (Set(sigmaDTypes) = Set(testDTypes)) then
      resultStr := Concatenation(resultStr, " is passed.");
      for decompositionType in RecNames(sigmaData[dimA]) do
        sigmaWords := sigmaData[dimA].(decompositionType);
        testWords := testData[dimA].(decompositionType);
        resultStr := Concatenation(resultStr, "\n", settings.printing.indent, "Test 'Comparison' for ", decompositionType);
        if (Set(sigmaWords) = Set(testWords)) then
          resultStr := Concatenation(resultStr, " is passed.");
        else
          resultStr := Concatenation(resultStr, getMessageForFailedTest(testWords, sigmaWords));
        fi;
      od;
    else
      resultStr := Concatenation(resultStr, getMessageForFailedTest(testDTypes, sigmaDTypes));
    fi;
    Add(results, resultStr);
  od;

  return Concatenation("\nTests:\n", JoinStringsWithSeparator(results, "\n"));
end;