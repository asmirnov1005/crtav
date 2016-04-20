CPrint := function (arg)
	local step, i;
	step := arg[1];
	Remove(arg, 1);
	Print(JoinStringsWithSeparator(step, "."), ".  ");
	for i in [1..Length(arg)] do
		Print(arg[i]);
	od;
	Print("\n\n");
end;;

SPrint := function (arg)
	local shift, i;
	shift := arg[1];
	Remove(arg, 1);
	Print(JoinStringsWithSeparator(List([1..shift + 1], s -> "  "), ""));
	for i in [1..Length(arg)] do
		Print(arg[i]);
	od;
	Print("\n\n");
end;;

SkipStrings := function (arg)
	local i;
	if Length(arg) = 0 then
		Print("\n");
	else
		for i in [1..arg[1]] do
			Print("\n");
		od;
	fi;
end;;

PrintSeparator := function ()
	Print(List([1..75], s -> '-'), "\n\n");
end;;

PrintBigSeparator := function ()
	Print(List([1..100], s -> 'X'), "\n\n");
end;;

PrintGiantSeparator := function ()
	Print(List([1..100], s -> 'o'), "\n");
	Print(List([1..100], s -> 'O'), "\n");
	Print(List([1..100], s -> 'o'), "\n\n");
end;;

ErrorNotice := function (arg)
	local i;
	Print("\nСООБЩЕНИЕ ОБ ОШИБКЕ:\n");
	for i in [1..Length(arg)] do
		Print(arg[i]);
	od;
	Print("\n\n");
end;;

# =================================================================================================

DataLengthIndicator := function (arg)
	local shift, dataList, dataName, min, max;
	shift := arg[1];
	dataList := arg[2];
	dataName := arg[3];
	min := 1;
	if Length(arg) > 3 then
		min := arg[4];
	fi;
	max := 1;
	if Length(arg) > 4 then
		max := arg[5];
	fi;
	if Length(dataList) < min then
		SPrint(shift, "Данная ситуация невозможна, поскольку не было найдено");
		SPrint(shift, "ни одного подходящего кандидата на роль ", dataName, "!");
	fi;
	if Length(dataList) > max then
		SPrint(shift, "Количество различных кандидатов на роль ", dataName, ": ", Length(dataList));
	fi;
end;;