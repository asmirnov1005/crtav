return function ()
  local isEmpty,
        head, tail, word;

  isEmpty := function ()
    return word = "";
  end;

  head := fail;
  tail := fail;
  word := "";

  return rec(
    addSymbolFromEdge := function (edge)
      if edge.value = "" then
        return false;
      fi;
      if isEmpty() then
        head := edge.head;
        tail := edge.tail;
        word := edge.value;

        return true;
      else
        if head = edge.head then
          head := edge.tail;
          word := Concatenation(edge.value, word);

          return true;
        elif head = edge.tail then
          head := edge.head;
          word := Concatenation(edge.value, word);

          return true;
        elif tail = edge.head then
          tail := edge.tail;
          word := Concatenation(word, edge.value);

          return true;
        elif tail = edge.tail then
          tail := edge.head;
          word := Concatenation(word, edge.value);

          return true;
        else
          return false;
        fi;
      fi;
    end,

    getWord := function ()
      return word;
    end,

    isCycle := function ()
      return not isEmpty() and head = tail;
    end,

    toString := function ()
      return Concatenation("|", String(head), ">-", word, "-|", String(tail), ">");
    end
  );
end;