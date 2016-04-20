INPUT_MODE := "UpTo5";;

Read(Concatenation("/crtav/Data/Input", INPUT_MODE, ".g"));;

Read("/crtav/Lib/Print.g");;
Read("/crtav/Lib/Classes.g");;
Read("/crtav/Lib/Helpers.g");;
Read("/crtav/Lib/GroupRepresentation.g");;
Read("/crtav/Lib/AdmissibleTransformations.g");;
Read("/crtav/Lib/SelectComplexConjugations.g");;
Read("/crtav/Lib/SelectDeltaSubgroups.g");;
Read("/crtav/Lib/SelectG0Subgroup.g");;
Read("/crtav/Lib/SelectCMTypes.g");;
Read("/crtav/Lib/SigmaData.g");;
Read("/crtav/Lib/PrepareGeneralData.g");;

ALPHABET := SplitString(Flat(List([1..100], n -> List("ABCDEFGHIJKLMNOPQRSTUVWXYZ", s -> Concatenation(['('], [s], String(n), [')'], [' '])))), ' ');;
PRINT_ALL := false;

mainData := rec();;
resultData := [];;

for i1 in [1..Length(GaloisGroupsData)] do
	
	if i1 > 1 then
		PrintBigSeparator();
	fi;
	mainData.dimA := i1;
	CPrint([i1], "Размерность равна ", mainData.dimA);
	
	resultData[mainData.dimA] := [];
	
	mainData.allGaloisGroups := GaloisGroupsData[i1];
	if Length(mainData.allGaloisGroups) > 0 then
		mainData.permutationGroupsRepresentatives := ConstructPermuatationGroupsRepresentatives(mainData);
	fi;
	
	for i2 in [1..Length(mainData.allGaloisGroups)] do
		
		if i2 > 1 then
			PrintSeparator();
		fi;
		mainData.GaloisGroupId := i2;
		
		mainData.G := mainData.allGaloisGroups[i2];
		mainData.G := ConvertToPermutationGroup(mainData);
		mainData.orderG := Order(mainData.G);
		mainData.isGalois := mainData.dimA = mainData.orderG / 2;
		if mainData.isGalois then
			CPrint([i1, i2], "K / Q является расширением Галуа, L = K");
		else
			CPrint([i1, i2], "K / Q не является расширением Галуа, L = GalCl(K)");
		fi;
		if mainData.orderG < 2000 then
			SPrint(2, "Рассматривается группа Галуа G = Gal(L / K) = ", mainData.G, " = ", StructureDescription(mainData.G), " = SmallGroup(", IdGroup(mainData.G), ")");
		else
			SPrint(2, "Рассматривается группа Галуа G = Gal(L / K) = ", mainData.G, " = ", StructureDescription(mainData.G), " порядка ", mainData.orderG);
		fi;
		
		SPrint(2, "Вычисляются классы сопряжённости подгрупп группы G");
		mainData.subgroupsRepresentatives := List(ConjugacyClassesSubgroups(mainData.G), Representative);
		
		mainData.allAutG := Stack();
		SPrint(2, "Строятся автоморфизмы группы G");
		mainData.allAutG.push(AutomorphismGroup(mainData.G));
		SPrint(2, "Производится поиск кандидатов на роль комплексного сопряжения iota");
		mainData.allComplexConjugations := SelectComplexConjugations(mainData);
		DataLengthIndicator(2, mainData.allComplexConjugations, "iota");
		
		for i3 in [1..Length(mainData.allComplexConjugations)] do
			
			mainData.iotaId := i3;
			
			mainData.iota := mainData.allComplexConjugations[i3];
			CPrint([i1, i2, i3], "Комплексное сопряжение iota = ", mainData.iota);
			
			mainData.allAutG.push(FilterTransformationsFixingElement(mainData.iota, mainData.allAutG.top()));
			
			SPrint(3, "Производится поиск кандидатов на роль подгруппы Delta");
			mainData.allDeltaSubgroups := SelectDeltaSubgroups(mainData);
			DataLengthIndicator(3, mainData.allDeltaSubgroups, "Delta");
			
			for i4 in [1..Length(mainData.allDeltaSubgroups)] do
				
				mainData.DeltaId := i4;
				
				mainData.Delta := mainData.allDeltaSubgroups[i4];
				CPrint([i1, i2, i3, i4], "Delta = ", mainData.Delta, " = ", StructureDescription(mainData.Delta));
				SPrint(4, "|Delta| = ", Order(mainData.Delta));
				
				mainData.allAutG.push(FilterTransformationsFixingSubgroup(mainData.Delta, mainData.allAutG.top()));
				
				mainData.factorGByDeltaLeft := FactorsetOfGroupBySubgroup(mainData.G, mainData.Delta);
				SPrint(4, "Фактормножество Delta \\ G:");
				SPrint(4, List(
					mainData.factorGByDeltaLeft,
					class -> [class[1]]
				));
				
				SPrint(4, "Производится построение подгруппы G0");
				mainData.G0 := SelectG0Subgroup(mainData);
				
				SPrint(4, "Производится поиск всевозможных CM-типов");
				mainData.allCMTypes := SelectCMTypes(mainData, PRINT_ALL, 4);
				if Length(mainData.allCMTypes) > 1 then
					SPrint(4, "Количество различных CM-типов: ", Length(mainData.allCMTypes));
				fi;
				
				for i5 in [1..Length(mainData.allCMTypes)] do
					
					mainData.CMTypeId := i5;
					
					mainData.CMType := mainData.allCMTypes[i5];
					CPrint([i1, i2, i3, i4, i5], "Производится обработка данных для CM-типа ", ALPHABET[i5]);
					SPrint(5, List(
						mainData.CMType,
						class -> [class[1]]
					));
					
					mainData.sigmaData := GetSigmaData(mainData, PRINT_ALL, 5);
					
					if PRINT_ALL then
						for i6 in [1..Length(mainData.sigmaData)] do
							data := mainData.sigmaData[i6];
							SPrint(6, "sigmaData: ", data);
							SkipStrings(2);
						od;
					else
						SPrint(5, "Обработка данных по CM-типу ", ALPHABET[i5], " завершена");
					fi;
					
					Append(resultData[mainData.dimA], mainData.sigmaData);
					
				od;
				
				mainData.allAutG.pop();
				
			od;
			
			mainData.allAutG.pop();
			
		od;
		
		mainData.allAutG.pop();
		
	od;
	
od;;

PrintGiantSeparator();

resultData := PrepareGeneralData(resultData);;

for dimA in [1..Length(resultData)] do
	
	if dimA > 1 then
		PrintSeparator();
	fi;
	
	SPrint(1, "Таблица результатов для размерности ", dimA);
	data := resultData[dimA];
	
	for keys in data.keys() do
		
		SPrint(2, "Набору ключей");
		SPrint(2, List(NamesOfComponents(keys), keyName -> Concatenation(keyName, " = ", String(keys.(keyName)))));
		SPrint(2, "соответствуют следующие данные:");
		
		result := data.get(keys);
		
		for i in [1..Length(result)] do
			
			SPrint(3, i, ") Набор слов: ", result[i].words);
			SPrint(5, "p-ранг = ", result[i].pRank, ", a-число = ", result[i].aNumber);
			
			if PRINT_ALL then
				
				SPrint(5, "Элементы, приводящие к разложению:");
				
				for j in [1..Length(result[i].sigmas)] do
				
					SPrint(6, result[i].sigmas[j][1], " -> ", result[i].sigmas[j][2]);
				
				od;
				
			fi;
			
		od;
		
		SkipStrings(2);
		
	od;
	
od;;