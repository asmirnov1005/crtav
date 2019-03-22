return rec(
  dimensionFilter := "UpTo3",
  checkCalculationDuration := true,
  runTests := true,
  printing := rec(
    printToFile := true,
    outputFilepath := "output/result.txt",
    indent := "   ",
  ),
);