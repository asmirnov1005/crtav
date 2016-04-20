Stack := function ()
	local stack;
	stack := [];
	
	return rec(
		push := function (Element)
			Add(stack, Element);
			return Element;
		end,
		pop := function ()
			local element, topIndex;
			topIndex := Length(stack);
			element := stack[topIndex];
			Remove(stack, topIndex);
			return element;
		end,
		length := function ()
			return Length(stack);
		end,
		top := function ()
			local topIndex;
			topIndex := Length(stack);
			return stack[topIndex];
		end
	);
end;;

Hash := function ()
	local hash, Get;
	hash := [];
	
	Get := function (key)
		local hashElement;
		hashElement := First(hash, element -> element[1] = key);
		if hashElement = fail then
			return fail;
		else
			return hashElement[2];
		fi;
	end;
	
	return rec(
		add := function (key, value)
			if value = fail then
				return fail;
			fi;
			if Get(key) = fail then
				Add(hash, [key, value]);
			else
				First(hash, element -> element[1] = key)[2] := value;
			fi;
			return value;
		end,
		get := function (key)
			return Get(key);
		end,
		keys := function ()
			return Set(List(hash, element -> element[1]));
		end,
		length := function ()
			return Length(hash);
		end
	);
end;;

Arrow := function (head, tail, value)
	local Head, Tail, Value, HeadFree, TailFree;
	Head := head;
	HeadFree := true;
	Tail := tail;
	TailFree := true;
	Value := value;
	
	return rec(
		head := Head,
		tail := Tail,
		value := Value,
		headFree := function ()
			return HeadFree;
		end,
		tailFree := function ()
			return TailFree;
		end,
		admitsArrowAtHeadSide := function (arrow)
			if not HeadFree then
				return fail;
			fi;
			if Value = 'F' then
				if arrow.value = 'F' then
					if Head = arrow.tail then
						return "Tail";
					else
						return fail;
					fi;
				elif arrow.value = 'V' then
					if Head = arrow.head then
						return "Head";
					else
						return fail;
					fi;
				fi;
			elif Value = 'V' then
				if arrow.value = 'F' then
					if Head = arrow.head then
						return "Head";
					else
						return fail;
					fi;
				elif arrow.value = 'V' then
					if Head = arrow.tail then
						return "Tail";
					else
						return fail;
					fi;
				fi;
			fi;
		end,
		admitsArrowAtTailSide := function (arrow)
			if not TailFree then
				return fail;
			fi;
			if Value = 'F' then
				if arrow.value = 'F' then
					if Tail = arrow.head then
						return "Head";
					else
						return fail;
					fi;
				elif arrow.value = 'V' then
					if Tail = arrow.tail then
						return "Tail";
					else
						return fail;
					fi;
				fi;
			elif Value = 'V' then
				if arrow.value = 'F' then
					if Tail = arrow.tail then
						return "Tail";
					else
						return fail;
					fi;
				elif arrow.value = 'V' then
					if Tail = arrow.head then
						return "Head";
					else
						return fail;
					fi;
				fi;
			fi;
		end,
		closeHead := function ()
			HeadFree := false;
		end,
		closeTail := function ()
			TailFree := false;
		end,
		close := function ()
			HeadFree := false;
			TailFree := false;
		end,
		isCycle := function ()
			return Head = Tail;
		end,
		isInner := function ()
			return not HeadFree and not TailFree;
		end
	);
end;;

Chain := function (arrow)
	local Arrows, IsCycle;
	
	Arrows := [arrow];
	if arrow.isCycle() then
		arrow.close();
	fi;
	
	return rec(
		arrows := function ()
			return Arrows;
		end,
		addArrow := function (arrow)
			local currentId, currentTip, currentSide, side, oppositeTip, oppositeSide;
			
			for currentId in [1, Length(Arrows)] do
				currentTip := Arrows[currentId];
				oppositeTip := Arrows[Length(Arrows) - currentId + 1];
				for side in ["Head", "Tail"] do
					currentSide := currentTip.(Concatenation("admitsArrowAt", side, "Side"))(arrow);
					oppositeSide := "Head";
					if currentSide = "Head" then
						oppositeSide := "Tail";
					fi;
					if not currentSide = fail then
						currentTip.(Concatenation("close", side))();
						arrow.(Concatenation("close", currentSide))();
						if currentId = 1 then
							Arrows := Concatenation([arrow], Arrows);
						else
							Arrows := Concatenation(Arrows, [arrow]);
						fi;
						
						if not arrow.(Concatenation("admitsArrowAt", oppositeSide, "Side"))(oppositeTip) = fail then
							arrow.close();
							oppositeTip.close();
						fi;
						
						return true;
					fi;
				od;
			od;
			
			return false;
		end,
		isCycle := function ()
			return Arrows[1].isInner() and Arrows[Length(Arrows)].isInner();
		end
	);
end;;