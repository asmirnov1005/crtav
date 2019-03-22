return function (arg)
  local initList, initCondition, initException,
        list, condition, exceptIdenticallyEqual,
        i, j;

  initList := function ()
    if IsList(arg[1]) then
      list := arg[1];
    else
      Error("wrong first argument");
    fi;
  end;

  initCondition := function ()
    if Length(arg) > 1 then
      if IsFunction(arg[2]) then
        condition := arg[2];
      else
        Error("wrong second argument");
      fi;
    else
      condition := function (elem1, elem2)
        return elem1 = elem2;
      end;
    fi;
  end;

  initException := function ()
    if Length(arg) > 2 then
      if IsBool(arg[3]) then
        exceptIdenticallyEqual := arg[3];
      else
        Error("wrong third argument");
      fi;
    else
      exceptIdenticallyEqual := true;
    fi;
  end;

  initList();
  initCondition();
  initException();

  if IsEmpty(list) or (exceptIdenticallyEqual and Length(list) = 1) then
    return true;
  fi;
  for i in [1..Length(list)] do
    for j in [1..Length(list)] do
      if exceptIdenticallyEqual and i = j then
        continue;
      fi;
      if not condition(list[i], list[j]) then
        return false;
      fi;
    od;
  od;

  return true;
end;