return function (arg)
  local initSet, initGroup, initAction,
        set, group, action;

  initSet := function ()
    if IsGroup(arg[1]) then
      set := Elements(arg[1]);
    elif IsRecord(arg[1]) and "getClasses" in RecNames(arg[1]) then
      set := arg[1].getClasses();
    elif IsSet(arg[1]) then
      set := arg[1];
    else
      Error("wrong first argument");
    fi;
  end;

  initGroup := function ()
    if IsGroup(arg[2]) then
      group := arg[2];
    else
      Error("wrong second argument");
    fi;
  end;

  initAction := function ()
    if Length(arg) > 2 then
      if IsFunction(arg[3]) then
        action := arg[3];
      else
        Error("wrong third argument");
      fi;
    else
      action := function (elem, g)
        return g * elem;
      end;
    fi;
  end;

  initSet();
  initGroup();
  initAction();

  return Set(List(set, function (elem)
    local class;

    class := List(Elements(group), g -> action(elem, g));
    if IsSet(elem) then
      return Set(Flat(class));
    else
      return Set(class);
    fi;
  end));
end;