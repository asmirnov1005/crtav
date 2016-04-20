Read("/crtav/Lib/AdmissibleTransformations.g");;

SelectComplexConjugations := function (mainData)
	local complexConjugations;
	complexConjugations := Filtered(Elements(Centre(mainData.G)), g -> Order(g) = 2);
	if Length(complexConjugations) > 1 then
		complexConjugations := SelectNonEquivalentElements(complexConjugations, mainData.allAutG.top());
	fi;
	return complexConjugations;
end;;