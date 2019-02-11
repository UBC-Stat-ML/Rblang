# Rblang

## R package to interface with blang CLI
The package is currently in a fairly rudimentary stage, and only supports certain functions. For the time being it allows you to run a blang model through R and return the results as an R dataframe. The functions will only work where the blang CLI command works. As such it is not possible to run models within blangSDK and blangExample. Additionally, it assumes that the project folder is within the same directory as blangSDK.

-------

## Installation
(Requires blang CLI to be setup already)
1. Install the [devtools](https://cran.r-project.org/web/packages/devtools/index.html) package
in RStudio and load it:
```
install.packages("devtools")
library(devtools)
```
2. Install this package using the ```install_github``` function:
```
install_github("UBC-Stat-ML/Rblang")
```
-----

## How to use the package

The package consists of three functions at the moment:
```r
Rblang::blangModel()
Rblang::run.blangModel()
Rblang::getResult.blangModel()
```

More information about each function is available via the help pages. To begin, load the library and create a model. This function can take in a variety of optional arguments but the only required ones are `model.name` and `project.path`.

- `model.name`: name of blang model to be run.
- `project.path`: path to the blang project directory. (make sure the project is in the same directory as blangSDK)
- `blang.args`: a string of blang runtime arguments to run.
- `data`: an R dataframe containing the observations passed into blang. It takes the df, converts it to a csv and passes that csv into blang.
- `data.name`: set to the name of the parameter for the data passed in.
- `out.loc`: specify an output location different to the default blang results folders.

```r
library(Rblang)

mod <- blangModel(project.path = ".../blangProjectName", model.name = "MyModel")
```

The `run.blangModel` function has now been modified to return another model object unique to this run. Additionally, you can choose to overwrite the default run arguments specified using `blangModel` to modify each run using the optional `run.args` parameter.
```r
run1 <- run.blangModel(mod)
```
After the run is completed, the path to the results folder is stored by reading the sym-link created by blang and a list of the files in the samples folder as well as the temperatures.csv file:
```r
 # The path to the results folder is accessed via:
run1$results.path

 # The list of files in the samples folder:
 run1$samples

 # The temperatures.csv is returned as a df via:
 temps <- run1$temps
```

And finally you can retrieve the results by using `getResult.blangModel()` and passing in the model and the name of the random variable:
```r
y <- getResult.blangModel(run1, "y")

hist(y$value, probability = TRUE)
```
