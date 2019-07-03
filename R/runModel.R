#' Run the given blang model
#'
#' Given the name of a blang model (name of .bl file), run
#' the model with no additional arguments.
#'
#' @param obj is a blangModel object, which will be run with the
#'     arguments provided to it via obj$blang.args
#' @param run.args optional parameter that allows you to modify
#'     the default blangModel$blang.args for this run. If NULL,
#'     it will just use blangModel$blang.args.
#' @return returns a blangModel object with this runs results
#'     path and arguments. After a run is complete, the list of
#'     sampled variables can be accessed via modelName$samples
#'     and the temperatures via modelName$temps.
#' @export
run.blangModel <- function(obj, run.args = NULL) {
  curdir = getwd()
  setwd(obj$project.path)

  # blang = sub("[^/]+$", "blangSDK/build/install/blang/bin/blang", obj$project.path)

  if(is.null(run.args)) { run.args <- obj$blang.args }
  system2(command = 'blang', args = run.args)

  obj$results.path <- paste(obj$project.path,
                            "/results/",
                            Sys.readlink(paste(obj$project.path, "/results/latest", sep="")),
                            sep = "")
  obj$blang.args <- run.args
  obj$samples <- list.files(paste(obj$results.path, "/samples/", sep=""))
  obj$temps <- read.csv(paste(obj$results.path, "/monitoring/temperatures.csv", sep=""), header = TRUE, sep = ",")

  setwd(curdir)
  return(obj)
}
