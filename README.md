### User Guide to CRTAV Project

The project is built upon the algorithm described in *Smirnov A., Zaytsev A., "Computing Algorithm for Reduction Type of CM Abelian Varieties"*.

To use the program:
1. In the *main.g* file, specify the full path from the GAP root folder to the project's root folder as `ROOT_DIR`. Assume the whole project is contained within the *crtav* folder located inside the *projects* subfolder of the GAP root folder, therefore `ROOT_DIR = "projects/crtav/"`.
2. Launch GAP and run the command: `Read("projects/crtav/main.g")`.

By default, the program displays the algorithm execution results and launches the tests, while the output is sent to the file *output/result.txt*. This can be modified by changing the settings in *settings.g*.

The following parameters are given:

* `dimensionFilter` may take the values of `"N"` or `"UpToN"`, where *N* is a number from 1 to 5. In the first case, the program calculates the results for the *N* dimension. In the second case, for all dimensions from 1 to *N*.
* `checkCalculationDuration` accepts `true|false` values. With `true`, the program displays total execution time (except the time for printing results).
* `runTests` accepts `true|false` values and is responsible for launching the tests.
* `printing` is a group of parameters that includes the following:
  * `printToFile` accepts `true|false` values. With `true`, everything printed in the console is sent to *output/result.txt*.
  * `outputFilepath` accepts any string value that defines the path from the project root folder to the *txt* file containing the results of the program execution.
  * `indent` accepts any string value that defines the indentation for printing results (e.g. indentation may be done with tabs if you print `indent := "\t"`).

---

The program has been tested in the following environment:
* Device: ASUS X554L (laptop)
* OS: Windows 10 Home
* GAP: v4.10.0