#' Setup RStudio Package Manager Repository Based on the Current Operating System
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @return Returns the repository url.
#' @export
Repository <- function(path) {
  # https://www.r-bloggers.com/2015/06/identifying-the-os-from-r/
  OS <- function() {
    sysinf <- Sys.info()
    if (!is.null(sysinf)) {
      os <- sysinf["sysname"]
      if (os == "Darwin") {
        os <- "osx"
      }
    } else { ## mystery machine
      os <- .Platform$OS.type
      r_version <- R.version$os
      if (grepl("^darwin", r_version)) {
        os <- "osx"
      }
      if (grepl("linux-gnu", r_version)) {
        os <- "linux"
      }
    }
    tolower(os)
  }
  Distro <- function() {
    lsb <- LSBRelease()
    if (is.null(lsb)) {
      os_release <- OSRelease()
      if (is.null(os_release)) {
        stop(
          "`LSBRelease` and `OSRelease` failed."
        )
      } else {
        return(os_release)
      }
    } else {
      return(lsb)
    }
  }
  LSBRelease <- function() {
    if (
      nzchar(
        Sys.which("lsb_release")
      )
    ) {
      # distributions with lsb_release
      out <- sapply(
        X = c(
          "-is",
          "-rs",
          "-cs"
        ),
        FUN = function(arg) {
          system(
            paste(
              "lsb_release",
              arg
            ),
            intern = TRUE
          )
        }
      )
      names(out) <- c(
        "distro",
        "release",
        "codename"
      )
      return(out)
    } else {
      return(NULL)
    }
  }
  OSRelease <- function() {
    if (file.exists("/etc/os-release")) {
      os_release <- readLines("/etc/os-release")
    } else {
      os_release <- NULL
    }
    if (!is.null(os_release)) {
      vals <- as.list(sub('^.*="?(.*?)"?$', "\\1", os_release))
      names(vals) <- sub("^(.*)=.*$", "\\1", os_release)
      out <- list(
        id = vals[["ID"]],
        version = vals[["VERSION_ID"]]
      )
      if ("VERSION_CODENAME" %in% names(vals)) {
        out$codename <- vals[["VERSION_CODENAME"]]
      } else {
        out$codename <- vals[["PRETTY_NAME"]]
      }
      out <- as.vector(out)
      names(out) <- c(
        "distro",
        "release",
        "codename"
      )
      return(out)
    } else {
      return(NULL)
    }
  }

  # source
  src <- "https://packagemanager.rstudio.com/all/latest"
  repos <- src

  # set repos
  os <- OS()
  if (os == "osx") {
    repos <- src
  }
  if (os == "windows") {
    repos <- "https://packagemanager.rstudio.com/all/latest/bin/windows"
  }
  if (os == "linux") {
    distro <- Distro()
    if (is.null(distro)) {
      repos <- src
    } else {
      repos <- src
      if (tolower(distro["distro"]) == "ubuntu") {
        if (distro["codename"] == "bionic") {
          repos <- "https://packagemanager.rstudio.com/all/__linux__/bionic/latest"
        }
        if (distro["codename"] == "focal") {
          repos <- "https://packagemanager.rstudio.com/all/__linux__/focal/latest"
        }
        if (distro["codename"] == "jammy") {
          repos <- "https://packagemanager.rstudio.com/all/__linux__/jammy/latest"
        }
      }
      # populate the rest of the available repositories
    }
  }
  return(repos)
}
