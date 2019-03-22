ROOT_DIR := "projects/crtav/";

# Independent imports
settings := ReadAsFunction(Concatenation(ROOT_DIR, "settings.g"))();
groupData := ReadAsFunction(Concatenation(ROOT_DIR, "data/groups.g"))();
testData := ReadAsFunction(Concatenation(ROOT_DIR, "data/tests.g"))();
Chain := ReadAsFunction(Concatenation(ROOT_DIR, "classes/chain.g"))();
Edge := ReadAsFunction(Concatenation(ROOT_DIR, "classes/edge.g"))();
Stack := ReadAsFunction(Concatenation(ROOT_DIR, "classes/stack.g"))();
printService := ReadAsFunction(Concatenation(ROOT_DIR, "services/print.g"))();
transformationsService := ReadAsFunction(Concatenation(ROOT_DIR, "services/transformations.g"))();
checkForEachPair := ReadAsFunction(Concatenation(ROOT_DIR, "functions/check_for_each_pair.g"))();
constructFactorset := ReadAsFunction(Concatenation(ROOT_DIR, "functions/construct_factorset.g"))();
indexOf := ReadAsFunction(Concatenation(ROOT_DIR, "functions/index_of.g"))();
skipDimension := ReadAsFunction(Concatenation(ROOT_DIR, "functions/skip_dimension.g"))();
stringifyCalculationDuration := ReadAsFunction(Concatenation(ROOT_DIR, "functions/stringify_calculation_duration.g"))();
stringifyResults := ReadAsFunction(Concatenation(ROOT_DIR, "functions/stringify_results.g"))();
stringifyTests := ReadAsFunction(Concatenation(ROOT_DIR, "functions/stringify_tests.g"))();

# Imports which depend from the independent
CircularWord := ReadAsFunction(Concatenation(ROOT_DIR, "classes/circular_word.g"))();
getCMTypes := ReadAsFunction(Concatenation(ROOT_DIR, "functions/get_cm_types.g"))();
getComplexConjugations := ReadAsFunction(Concatenation(ROOT_DIR, "functions/get_complex_conjugations.g"))();
getDeltaSubgroups := ReadAsFunction(Concatenation(ROOT_DIR, "functions/get_delta_subgroups.g"))();

# Most dependent imports
getSigmaData := ReadAsFunction(Concatenation(ROOT_DIR, "functions/get_sigma_data.g"))();

sigmaData := [];
startTime := Runtime();
for dimA in [1..Length(groupData)] do

	sigmaData[dimA] := rec();
  if (skipDimension(dimA, settings.dimensionFilter)) then
    continue;
  fi;
	for G in groupData[dimA] do

		G := Image(IsomorphismPermGroup(G));
		representativesOfSubgroupsOfG := List(ConjugacyClassesSubgroups(G), Representative);
		admissibleAutomorphismsOfG := Stack();
		admissibleAutomorphismsOfG.push(AutomorphismGroup(G));
		complexConjugations := getComplexConjugations(G, admissibleAutomorphismsOfG.top());
		for iota in complexConjugations do

			admissibleAutomorphismsOfG.push(transformationsService.filterByElement(iota, admissibleAutomorphismsOfG.top()));
			deltaSubgroups := getDeltaSubgroups(dimA, G, iota, representativesOfSubgroupsOfG, admissibleAutomorphismsOfG.top());
			for delta in deltaSubgroups do

				admissibleAutomorphismsOfG.push(transformationsService.filterBySubgroup(delta, admissibleAutomorphismsOfG.top()));
				factorGByDeltaLeft := constructFactorset(G, delta);
        factorGByG0Left := constructFactorset(G, Group(Concatenation(GeneratorsOfGroup(delta), [ iota ])));
				CMTypes := getCMTypes(Order(G), iota, delta, factorGByDeltaLeft, representativesOfSubgroupsOfG, admissibleAutomorphismsOfG.top());
        for CMType in CMTypes do

          sigmaData[dimA] := getSigmaData(sigmaData[dimA], CMType, G, factorGByDeltaLeft, factorGByG0Left, admissibleAutomorphismsOfG.top());

        od;
				admissibleAutomorphismsOfG.pop();

			od;
			admissibleAutomorphismsOfG.pop();

		od;
		admissibleAutomorphismsOfG.pop();

	od;

od;;

printService.clear();
if (settings.checkCalculationDuration) then
  printService.print(Concatenation(stringifyCalculationDuration(startTime, Runtime()), "\n\n"));
fi;
printService.print(stringifyResults(sigmaData));
if (settings.runTests) then
  printService.print(Concatenation("\n\n", stringifyTests(sigmaData, testData)));
fi;