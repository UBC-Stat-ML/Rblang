#' Returns the samples of the given random variable as a dataframe.
#'
#' @param obj blangModel: the model from which the results are pulled
#' @param variable string: name of the random variable
#' @param output.path string: optional parameter to specify an output
#'     location to copy the csv files to. By default set to
#'     blangModel$out.loc (just a way to add another path without
#'     having to change the default model out.loc).
#' @return dataframe of the samples for the given random variable
#' @export
getResult.blangModel <- function(obj, variable, output.path=NULL) {
  #obj$results.path <- paste(obj$project.path, "/results/latest", sep = "")

  resfile <- obj$results.path
  path <- paste(resfile, "/samples/", variable, ".csv", sep = "")
  result <- read.csv(path, header = TRUE, sep = ",")

  #if (is.null(output.path)) {output.path <- obj$out.loc}
  if (!is.null(output.path)) {
    obj$out.loc <- output.path
    system2("cp", args = c("-v", resfile, obj$out.loc))
  }
  return(result)
}
