return function (head, tail, value)
  return rec(
    head := head,
    tail := tail,
    value := value
  );
end;