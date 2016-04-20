Read("/crtav/Lib/Print.g");;
Read("/crtav/Lib/Classes.g");;
Read("/crtav/Lib/Helpers.g");;

CollectArrowsToChains := function (Arrows, Chains)
	local chain, currentArrow, i, j;
	
	if Length(Arrows) = 0 then
		return Chains;
	fi;
	
	currentArrow := Arrows[1];
	Remove(Arrows, 1);
	chain := Chain(currentArrow);
	
	if not chain.isCycle() then
		while not chain.isCycle() do
			for i in [1..Length(Arrows)] do
				if chain.addArrow(Arrows[i]) then
					j := i;
					break;
				fi;
			od;
			Remove(Arrows, j);
		od;
	fi;
	
	Add(Chains, chain);
	return CollectArrowsToChains(Arrows, Chains);
end;;

ShiftLetters := function (word)
	local IsNeighbors, breaker, breakPoint, EachNeighborsAreNearby;
	breakPoint := 10000;
	
	if Length(word) < 2 or not 'F' in word then
		return word;
	fi;
	
	EachNeighborsAreNearby := function (Neighbors)
		local i;
		if Length(Neighbors) < 2 then
			return true;
		fi;
		for i in [2..Length(Neighbors)] do
			if not Neighbors[i] - Neighbors[i - 1] = 1 then
				return false;
			fi;
		od;
		return true;
	end;
	
	breaker := 0;
	while not (EachNeighborsAreNearby(Positions(word, 'F')) and Position(word, 'F') = 1) do
		breaker := breaker + 1;
		if breaker = breakPoint then
			return word;
		fi;
		
		word := Concatenation(word{[2..Length(word)]}, [word[1]]);
	od;
	
	return word;
end;;

PrepareWord := function (word)
	local partLengths, splittedWord, i;
	partLengths := DivisorsInt(Length(word));
	for i in [1..Length(partLengths)] do
		splittedWord := SplitStringToEqualPartsOfGivingLength(word, partLengths[i]);
		if PairwiseEqual(splittedWord) then
			return List(splittedWord, w -> ShiftLetters(w));
		fi;
	od;
end;;

PrepareWords := function (words)
	local preparedWords, i;
	preparedWords := [];
	for i in [1..Length(words)] do
		Append(preparedWords, PrepareWord(words[i]));
	od;
	Sort(preparedWords);
	return preparedWords;
end;;

ConstructH := function (mainData, sigma)
	local H, D, class, ActionOfD, IsInH;
	H := Set([]);
	D := Group([ sigma ]);
	
	ActionOfD := function (s, element)
		return Set(element * s);
	end;
	
	IsInH := function (element)
		local DClassOfElement;
		
		DClassOfElement := Set(List(Elements(D), s -> ActionOfD(s, element)));
		
		return IsSubset(mainData.CMType, DClassOfElement);
	end;
	
	for class in mainData.factorGByDeltaLeft do
		if IsInH(class) then
			AddSet(H, class);
		fi;
	od;
	
	return H;
end;;

OldGetParameters := function (mainData, sigma)
	local n, D, M, N, U, r, s, ConstructOrbit, ProperDivisors;
	D := [];
	M := [];
	N := [];
	r := [];
	s := [];
	
	ConstructOrbit := function (element, group)
		return Set(List(Elements(group), gElement -> Set(element * gElement)));
	end;
	
	ProperDivisors := function (a)
		return Filtered(DivisorsInt(a), d -> not d = a);
	end;
	
	for n in [1..2*mainData.dimA] do
		D[n] := Group([ sigma^n ]);
		M[n] := Set(Filtered(mainData.factorGByDeltaLeft, function (g)
			local i;
			for i in [0..n-1] do
				if not (IsSubset(mainData.CMType, ConstructOrbit(g * sigma^i, D[n])) or IsSubset(mainData.CMType, ConstructOrbit(mainData.iota * g * sigma^i, D[n]))) then
					return false;
				fi;
			od;
			return true;
		end));
		U := Union(List(ProperDivisors(n), d -> M[d]));
		N[n] := Set(Filtered(M[n], g -> not g in U));
		r[n] := Length(N[n]);
	od;
	
	return List(
		[1..2*mainData.dimA],
		k -> r[k]/k
	);
end;;

GetParameters := function (mainData, sigma)
	local n, D, M, N, U, r, s, ConstructOrbit, ProperDivisors;
	D := [];
	M := [];
	N := [];
	r := [];
	s := [];
	
	ConstructOrbit := function (element, group)
		return Set(List(Elements(group), gElement -> Set(element * gElement)));
	end;
	
	ProperDivisors := function (a)
		return Filtered(DivisorsInt(a), d -> not d = a);
	end;
	
	for n in [1..2*mainData.dimA] do
		D[n] := Group([ sigma^n ]);
		M[n] := Set(Filtered(mainData.factorGByDeltaLeft, g -> IsSubset(mainData.CMType, ConstructOrbit(g, D[n]))));
		U := Union(List(ProperDivisors(n), d -> M[d]));
		N[n] := Set(Filtered(M[n], g -> not g in U));
		r[n] := Length(N[n]);
	od;
	
	return List(
		[1..2*mainData.dimA],
		k -> 2 * r[k] / k
	);
end;;

GetSigmaData := function (mainData, printAll, shift)
	local sigmaData, i, j, allCyclicSubgroupsOfG, D, generatorsOfD, sigma, GetAllArrows, GetCountOfPrimeIdeals, words, pDecomposition, pRank, aNumber, qRank;
	
	sigmaData := [];
	
	if printAll then
		SPrint(shift, "Производится поиск всевозможных циклических подгрупп в G");
	fi;
	allCyclicSubgroupsOfG := Filtered(mainData.subgroupsRepresentatives, H -> IsCyclic(H));

	GetAllArrows := function (currentSigma)
		local arrows, element, countOfArrows, k, GetElementId;
		arrows := Set([]);
		
		GetElementId := function (element)
			local elements, l;
			for l in [1..Length(mainData.factorGByDeltaLeft)] do
				if Set(element) = Set(mainData.factorGByDeltaLeft[l]) then
					return l;
				fi;
			od;
		end;
		
		countOfArrows := Length(mainData.factorGByDeltaLeft);
		for k in [1..countOfArrows] do
			element := mainData.factorGByDeltaLeft[k];
			if element in mainData.CMType then
				AddSet(arrows, Arrow(
					GetElementId(element * currentSigma), GetElementId(element), 'V'
				));
			else
				AddSet(arrows, Arrow(
					GetElementId(element), GetElementId(element * currentSigma), 'F'
				));
			fi;
		od;
		return arrows;
	end;
	
	GetCountOfPrimeIdeals := function (GroupLikeObject, subgroup)
		if IsGroup(GroupLikeObject) then
			return Length(FactorsetOfGroupBySubgroup(GroupLikeObject, subgroup, "right"));
		else
			return Length(Set(List(
				GroupLikeObject,
				class -> Set(List(
					Cartesian(class, Elements(subgroup)), newClass -> Product(newClass)
				))
			)));
		fi;
	end;
	
	for i in [1..Length(allCyclicSubgroupsOfG)] do
		
		if printAll then
			SPrint(shift + 1, "Данные по подгруппе обрабатываются (", i, " из ", Length(allCyclicSubgroupsOfG), ")");
		fi;
		
		D := allCyclicSubgroupsOfG[i];
			
		if printAll then
			SPrint(shift + 1, "Производится подсчёт числа идеалов в разложении p на каждом уровне...");
		fi;
		pDecomposition := [
			GetCountOfPrimeIdeals(mainData.factorGByDeltaLeft, D),
			GetCountOfPrimeIdeals(FactorsetOfGroupBySubgroup(mainData.G, mainData.G0), D)
		];
		
		if printAll then
			SPrint(shift + 1, "Начинается обработка данных для порождающих элементов подгруппы");
		fi;
		generatorsOfD := Set(Flat(List(
			ConjugateSubgroups(mainData.G, D),
			H -> Filtered(Elements(H), g -> Order(g) = Order(H))
		)));
		for j in [1..Length(generatorsOfD)] do
			
			if printAll then
				SPrint(shift + 2, "Обрабатывается порождающий элемент №", j, " (из ", Length(generatorsOfD), ")");
			fi;
			sigma := generatorsOfD[j];
			if printAll then
				SPrint(shift + 2, "Производится построение набора слов, соответствующего элементу...");
			fi;
			words := PrepareWords(List(
				CollectArrowsToChains(GetAllArrows(sigma), Set([])),
				chain -> List(chain.arrows(), arrow -> arrow.value)
			));
			pRank := Length(Filtered(words, word -> word = "F"));
			aNumber := Sum(List(words, word -> Length(Filtered(List([1..Length(word)], i -> Concatenation(word, [ word[1] ]){[i..i+1]}), pair -> pair = "FV"))));
			
			qRank := Length(ConstructH(mainData, sigma));
			
			Add(sigmaData, rec(
				sigma := sigma,
				GaloisGroupId := mainData.GaloisGroupId,
				
				# Keys
				Decomposition := pDecomposition,
				
				# Results
				words := words,
				pRank := pRank,
				aNumber := aNumber,
				cNumber := pRank + aNumber
			));
			
		od;
		
		if printAll then
			SPrint(shift + 1, "Подгруппа обработана (", i, " из ", Length(allCyclicSubgroupsOfG), ")");
		fi;
		
	od;;
	
	return sigmaData;
end;;