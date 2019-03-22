return function ()
	local topIndex,
        elements;

  topIndex := function ()
    return Length(elements);
  end;

	elements := [];

	return rec(
		push := function (Element)
			Add(elements, Element);

			return Element;
		end,

		pop := function ()
			local result;

			result := elements[topIndex()];
			Remove(elements, topIndex());

			return result;
		end,

		length := function ()
			return Length(elements);
		end,

		top := function ()
			return elements[topIndex()];
		end
	);
end;;