#' @export
#' Checks to see if blangSDK has already been installed, and whether or not the PATH to the Command Line Interface is set up correctly.
setupSDK <- function() {
  olddir <- getwd()
  instPath <- paste(find.package(package = "Rblang"),"/blang",sep = "")
  blangPath <- paste(instPath,"/blangSDK-master/build/install/blang/bin/",sep = "")

  if (!checkPathSetup(blangPath)) {
    installSDK(olddir, instPath)
  }
  checkCLI(blangPath)
}

#' Downloads current blangSDK repository from GitHub and places it in project folder.
installSDK <- function(olddir, instPath) {
  download.file("https://github.com/UBC-Stat-ML/blangSDK/archive/master.zip"
                , destfile = paste(instPath,"blangSDK-master.zip",sep = "/"))
  unzip(zipfile = paste(instPath,"blangSDK-master.zip",sep = "/"), exdir = paste(instPath,sep = ""))

  setwd(paste(instPath, "/blangSDK-master/",sep = ""))
  system("chmod +x * setup-cli.sh")

  system(paste("source ", instPath, "/blangSDK-master/setup-cli.sh",sep = ""))
  setwd(olddir)
}

#' Checks for existence of blangSDK Command Line Interface files
checkPathSetup <- function(blangPath) {
  return(file.exists(paste(blangPath,"blang",sep = "")))
}

#' Checks, and manages blang CLI PATH setup
checkCLI <- function(blangPath) {
  path <- Sys.getenv("PATH")
  paths <- strsplit(path,":")
  pathExists <- FALSE

  for (i in 1:length(paths[[1]])) {
    if (paths[[1]][i] == blangPath) {
      pathExists <- TRUE
    }
  }

  if (!pathExists) {
    Sys.setenv(PATH = paste(path,":",blangPath,sep = ""))
  }
}

