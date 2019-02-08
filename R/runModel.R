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
#' @export
run.blangModel <- function(obj, run.args = NULL) {
  curdir = getwd()
  setwd(obj$project.path)
  blang = sub("[^/]+$", "blangsdk/build/install/blang/bin/blang", obj$project.path)

  if(is.null(run.args)) { run.args <- obj$blang.args }
  system2(command = blang, args = run.args)

  obj$results.path <- paste(obj$project.path, "/results/latest", sep="")

  setwd(curdir)
}
