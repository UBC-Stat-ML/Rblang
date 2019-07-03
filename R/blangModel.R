#' Sets up a blang Model
#'
#'
#' @param project.path filepath to the blang project root directory
#' @param model.name the name of the model to be run
#' @param data a dataframe to be passed into the model
#' @param blang.args a string of the runtime arguments to be used by blang
#' @param out.loc set to TRUE to output results in current working
#'     directory instead of Blang project directory.
#' @param data.name optional string argument, set to the name of the
#'     GlobalDataSource param in the blang model if known, otherwise
#'     uses the name of the data param to pass into blang.
#' @param post.process Sets post-processing option. FALSE by default,
#'     if TRUE, uses Blang's DefaultPostProcessor.
#' @export
blangModel <- function(project.path = '', model.name = '',
                       blang.args = NULL,
                       data = NULL, data.name = NULL,
                       out.loc = FALSE, post.processor = FALSE) {
  cur.dir = getwd()
  if (!out.loc) { setwd(project.path) }

  blang.args <- paste("--model", model.name, sep=" ", blang.args)
  # Currently names the csv file passed into blang based on the variable
  # name of the dataframe passed in. Could change to be more robust.
  #
  if (!is.null(data) && !is.null(data.name)) {
    filename = paste(getwd(), "/", data.name, ".csv", sep = "")
    write.csv(data, file = filename, sep = ",")
    blang.args = paste(blang.args, paste("--", data.name), filename, sep = " ")
  }
  else if (!is.null(data) && is.null(data.name)) {
    filename = paste(cur.dir, "/", as.character(data), ".csv", sep = "")
    write.csv(data, file = filename, sep = ",")
    blang.args = paste(blang.args, paste("--", as.character(data)), filename, sep = " ")
  }

  modelargs <- list(project.path = project.path, model.name = model.name,
                    data = data, blang.args = blang.args, out.loc = out.loc,
                    data.name = data.name, results.path = '', samples = NULL, temps = NULL)
  attr(modelargs, "class") <- "blangModel"
  modelargs
}
