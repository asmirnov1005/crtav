Read("/crtav/Lib/AdmissibleTransformations.g");;

SelectG0Subgroup := function (mainData)
	return Group(Concatenation(
		GeneratorsOfGroup(mainData.Delta), [ mainData.iota ]
	));
end;;