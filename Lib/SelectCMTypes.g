Read("/crtav/Lib/Print.g");;
Read("/crtav/Lib/Helpers.g");;

SelectCMTypes := function (mainData, printAll, shift)
	local CMTypes, ConjugateOfElement, IsNotConjugatedPair, SelectNonConjugatedCMTypes, SelectPrimitiveCMTypes, SelectNonEquivalentCMTypes, OldSelectNonEquivalentCMTypes, OldOldSelectNonEquivalentCMTypes;
	
	ConjugateOfElement := function (E)
		return Set(List(E, element -> mainData.iota * element));
	end;
	
	IsNotConjugatedPair := function (E1, E2)
		return not ConjugateOfElement(E1) = E2;
	end;
	
	SelectNonConjugatedCMTypes := function (allCMTypes)
		local nonConjugatedCMTypes, i;
		nonConjugatedCMTypes := Set([ allCMTypes[1] ]);
		for i in [2..Length(allCMTypes)] do
			if not Set(List(allCMTypes[i], element -> ConjugateOfElement(element))) in nonConjugatedCMTypes then
				AddSet(nonConjugatedCMTypes, allCMTypes[i]);
			fi;
		od;
		return nonConjugatedCMTypes;
	end;
	
	SelectPrimitiveCMTypes := function (allCMTypes)
		local i, primitiveCMTypes, IsPrimitive;
		primitiveCMTypes := Set([]);
		
		IsPrimitive := function (CMType)
			local j, allCMSubgroups, CMTypeRestriction, IsCMType;
			allCMSubgroups := Filtered(
				mainData.subgroupsRepresentatives,
				function (H)
					return
						Order(H) > Order(mainData.Delta) and
						IsSubgroup(H, mainData.Delta) and
						not mainData.iota in H;
				end
			);
			
			CMTypeRestriction := function (CMType, CMSubgroup)
				local CMTypeRepresentatives;
				CMTypeRepresentatives := List(CMType, class -> class[1]);
				return Set(List(
					CMTypeRepresentatives,
					element -> Set(Elements(CMSubgroup) * element)
				));
			end;
			
			IsCMType := function (preCMType, CMSubgroup)
				local k, l;
				if not Length(preCMType) = mainData.orderG / (2 * Order(CMSubgroup)) then
					return false;
				fi;
				for k in [1..Length(preCMType)-1] do
					for l in [k+1..Length(preCMType)] do
						if Set(preCMType[k]) = Set(mainData.iota * preCMType[l]) then
							return false;
						fi;
					od;
				od;
				return true;
			end;
			
			for j in [1..Length(allCMSubgroups)] do
				if IsCMType(CMTypeRestriction(CMType, allCMSubgroups[j]), allCMSubgroups[j]) then
					return true;
				fi;
			od;
			
			return false;
		end;
		
		for i in [1..Length(allCMTypes)] do
			if not IsPrimitive(allCMTypes[i]) then
				AddSet(primitiveCMTypes, allCMTypes[i]);
			fi;
		od;
		
		return primitiveCMTypes;
	end;
	
	SelectNonEquivalentCMTypes := function (allCMTypes)
		local nonEquivalentCMTypes, AutG, automorphisms, ConstructSMTypeOrbit, i, actionType;
		SPrint(shift + 1, "Шаг 1 из ", Length(allCMTypes), ": 1 неэквивалентных CM-типов");
		
		automorphisms := Elements(mainData.allAutG.top());
		
		ConstructSMTypeOrbit := function (CMType)
			local CMTypeImage;
			
			CMTypeImage := function (automorphism)
				return Set(List(
					CMType,
					element -> Set(Image(automorphism, element))
				));
			end;
			
			return Set(List(
				automorphisms,
				automorphism -> CMTypeImage(automorphism)
			));
		end;
		
		nonEquivalentCMTypes := Set([ rec(
			CMType := allCMTypes[1],
			CMTypeOrbit := ConstructSMTypeOrbit(allCMTypes[1])
		) ]);
		
		for i in [2..Length(allCMTypes)] do
			SPrint(shift + 1, "Шаг ", i, " из ", Length(allCMTypes), ": ", Length(nonEquivalentCMTypes), " неэквивалентных CM-типов");
			if First(nonEquivalentCMTypes, CMTypeData -> allCMTypes[i] in CMTypeData.CMTypeOrbit) = fail then
				AddSet(nonEquivalentCMTypes, rec(
					CMType := allCMTypes[i],
					CMTypeOrbit := ConstructSMTypeOrbit(allCMTypes[i])
				));
			fi;
		od;
		
		return Set(List(nonEquivalentCMTypes, CMTypeData -> CMTypeData.CMType));
	end;
	
	SPrint(shift, "1) Составляются всевозможные наборы из ", mainData.dimA * 2, " элементов по ", mainData.dimA);
	CMTypes := Set(List(Combinations(mainData.factorGByDeltaLeft, Length(mainData.factorGByDeltaLeft) / 2), l -> Set(l)));
	SPrint(shift, "1) Всего: ", Length(CMTypes), " кандидатов в CM-типы");
	SPrint(shift, "2) Отсеиваются наборы, в которых нет попарно сопряжённых элементов");
	CMTypes := Filtered(CMTypes, CMType -> ForAnyPair(CMType, IsNotConjugatedPair));;
	SPrint(shift, "2) Всего: ", Length(CMTypes), " CM-типов");
	SPrint(shift, "3) Отбираются CM-типы, которые не сопряжены между собой");
	CMTypes := SelectNonConjugatedCMTypes(CMTypes);
	SPrint(shift, "3) Осталось: ", Length(CMTypes), " CM-типов");
	SPrint(shift, "4) Удаляются не примитивные CM-типы");
	CMTypes := SelectPrimitiveCMTypes(CMTypes);
	if Length(CMTypes) = 0 then
		SPrint(shift, "Не найдено ни одного примитивного CM-типа");
		return Set([]);
	fi;
	SPrint(shift, "4) Осталось: ", Length(CMTypes), " CM-типов");
	SPrint(shift, "5) Удаляются CM-типы, которые можно получить из других заменой переменных");
	CMTypes := SelectNonEquivalentCMTypes(CMTypes);
	SPrint(shift, "5) Итого: ", Length(CMTypes), " CM-типов");
	SPrint(shift, "Поиск подходящих CM-типов завершён");
	
	return CMTypes;
end;;