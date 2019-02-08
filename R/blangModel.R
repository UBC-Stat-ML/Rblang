#' Runs a given blang Model
#'
#'
#' @param project.path filepath to the blang project root directory
#' @param model.name the name of the model to be run, as a string
#' @param data a dataframe the data passed into the model
#' @param blang.args a string of the runtime arguments to be used by blang
#' @param out.loc optional parameter to set the filepath of model result files
#' @param data.name optional string argument, set to the name of the
#'     GlobalDataSource param in the blang model if known, otherwise
#'     uses the name of the data param to pass into blang.
#' @return --
#' @export
blangModel <- function(project.path = '', model.name = '', data = NULL,
                       blang.args = paste('--model', model.name, sep=" "),
                       out.loc = NULL, data.name = NULL) {
  cur.dir = getwd()
  #setwd(project.path)

  # Currently names the csv file passed into blang based on the variable
  # name of the dataframe passed in. Could change to be more robust.
  #
  if (!is.null(data) && !is.null(data.name)) {
    filename = paste(cur.dir, "/", data.name, ".csv", sep = "")
    write.csv(data, file = filename, sep = ",")
    blang.args = paste(blang.args, paste("--", data.name), filename, sep = " ")
  }
  else if (!is.null(data) && is.null(data.name)) {
    filename = paste(cur.dir, "/", as.character(data), ".csv", sep = "")
    write.csv(data, file = filename, sep = ",")
    blang.args = paste(blang.args, paste("--", as.character(data)), filename, sep = " ")
  }

  modelargs <- list(project.path = project.path, model.name = model.name,
                    data = data, blang.args = blang.args,out.loc = out.loc,
                    data.name = data.name, results.path = '', rvars = c())
  attr(modelargs, "class") <- "blangModel"
  modelargs
  #runModel(project.path, model.name, blang.args, var.name, out.loc)
}