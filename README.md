# Rblang

## R package to interface with blang CLI
The package is currently in a fairly rudimentary stage, and only supports certain functions. For the time being it allows you to run a blang model through R and return the results as an R dataframe. The functions will only work where the blang CLI command works. As such it is not possible to run models within blangSDK and blangExample. Additionally, it assumes that the project folder is within the same directory as blangSDK.

## Usage:
1. Load the library in R and define a blangModel. The only required arguments are ```project.path``` and ```model.name``` and there are options to specify other attributes. You can refer to help pages by searching for ```Rblang::functionName``` in the help tab:
```
library(Rblang)

model <- blangModel(project.path = "path to workspace/blangProjectName", model.name = "MyModel")
```
2. Run the model, any additional temporary arguments to be passed in can be done via the ```run.args``` argument. (in this case, it run ```blang --model MyModel.bl``` via the command line):
```
run.blangModel(model) # or run.blangModel(model, run.args = "add extra arguments")
```
3. Grab the results of the given random variable and load it as a dataframe:
```
rVar <- getResult.blangModel(model, "rVarName")
```

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
