return rec(
  clear := function ()
    if (settings.printing.printToFile) then
      PrintTo(Concatenation(ROOT_DIR, settings.printing.outputFilepath), "");
    fi;
  end,

  print := function (message)
    Print(message);
    if (settings.printing.printToFile) then
      AppendTo(Concatenation(ROOT_DIR, settings.printing.outputFilepath), message);
    fi;
  end
);