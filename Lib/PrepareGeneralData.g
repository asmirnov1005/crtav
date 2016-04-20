Read("/crtav/Lib/Classes.g");;
Read("/crtav/Lib/Helpers.g");;

WordsAlreadyInCollection := function (collection, words)
	local i, IsEquiv;
	
	IsEquiv := function (words1, words2)
		local i1, i2, IsEquivWords;
		
		IsEquivWords := function (word1, word2)
			local j;
			if word1 = word2 then
				return true;
			fi;
			if not Length(word1) = Length(word2) then
				return false;
			fi;
			if not Length(Filtered(word1, c -> c = 'F')) = Length(Filtered(word2, c -> c = 'F')) then
				return false;
			fi;
			for j in [1..Length(word1)-1] do
				word2 := Concatenation(word2{[2..Length(word2)]}, [word2[1]]);
				if word1 = word2 then
					return true;
				fi;
			od;
			return false;
		end;
		
		if not Set(List(words1, w -> Length(w))) = Set(List(words2, w -> Length(w))) then
			return false;
		fi;
		for i1 in [1..Length(words1)] do
			for i2 in [1..Length(words2)] do
				if IsEquivWords(words1[i1], words2[i2]) then
					Remove(words2, i2);
					break;
				fi;
			od;
		od;
		if Length(words2) > 0 then
			return false;
		else
			return true;
		fi;
	end;
	
	for i in [1..Length(collection)] do
		if IsEquiv(collection[i], words) then
			return true;
		fi;
	od;
	return false;
end;;

SelectSubrecord := function (record, keys)
	local key, subrecord;
	subrecord := rec();
	for key in keys do
		subrecord.(key) := record.(key);
	od;
	return subrecord;
end;;

PrepareData := function (data)
	return SelectSubrecord(data, ["words", "pRank", "aNumber"]);
end;;

OldPrepareGeneralDataOfFixedDimension := function (generalData)
	local i, data, resultData, pDecomposition, decompositionData;
	resultData := Hash();
	for i in [1..Length(generalData)] do
		data := generalData[i];
		pDecomposition := data.pDecomposition;
		decompositionData := resultData.get(pDecomposition);
		if decompositionData = fail then
			resultData.add(pDecomposition, Set([ data.words ]));
		else
			if not WordsAlreadyInCollection(decompositionData, CloneList(data.words)) then
				AddSet(decompositionData, data.words);
				resultData.add(pDecomposition, decompositionData);
			fi;
		fi;
	od;
	return resultData;
end;;

PrepareGeneralDataOfFixedDimension := function (generalData)
	local i, numberOfWordsCollection, data, resultData, keysNames, keys, keysValues;
	keysNames := ["Decomposition"];
	resultData := Hash();
	for i in [1..Length(generalData)] do
		data := generalData[i];
		keys := SelectSubrecord(data, keysNames);
		keysValues := resultData.get(keys);
		if keysValues = fail then
			resultData.add(keys, Set([ PrepareData(data) ]));
		else
			if not WordsAlreadyInCollection(List(keysValues, keyValue -> keyValue.words), CloneList(data.words)) then
				AddSet(keysValues, PrepareData(data));
				resultData.add(keys, keysValues);
			fi;
		fi;
	od;
	return resultData;
end;;

PrepareGeneralData := function (generalData)
	local dimA, resultData;
	resultData := [];
	for dimA in [1..Length(generalData)] do
		Add(resultData, PrepareGeneralDataOfFixedDimension(generalData[dimA]));
	od;
	return resultData;
end;;