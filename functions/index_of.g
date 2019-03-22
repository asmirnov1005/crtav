return function (arg)
  local initList, initElem, initIsEqual,
        list, elem, isEqual,
        i;

  initList := function ()
    if IsList(arg[1]) then
      list := arg[1];
    else
      Error("wrong first argument");
    fi;
  end;

  initElem := function ()
    elem := arg[2];
  end;

  initIsEqual := function ()
    if Length(arg) > 2 then
      if IsFunction(arg[3]) then
        isEqual := arg[3];
      else
        Error("wrong third argument");
      fi;
    else
      isEqual := function (elem1, elem2)
        return elem1 = elem2;
      end;
    fi;
  end;

  initList();
  initElem();
  initIsEqual();

  for i in [1..Length(list)] do
    if isEqual(list[i], elem) then
      return i;
    fi;
  od;

  return -1;
end;