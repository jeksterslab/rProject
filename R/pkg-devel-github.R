#' Install Development Packages from Github
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @export
PkgDevelGitHub <- function(path) {
  lib <- LibPaths(path = path)
  installed <- utils::installed.packages()
  pkg_installed <- installed[, "Package"]
  if (!("remotes" %in% pkg_installed)) {
    utils::install.packages(
      "remotes",
      repos = c(REPO_NAME = Repository(path = path)),
      lib = lib,
      quiet = TRUE
    )
  }
  pkg <- c(
    "rstudio/tinytex",
    "r-lib/cli",
    "r-lib/devtools",
    "r-hub/rhub"
  )
  for (i in seq_along(pkg)) {
    cat(
      paste0(
        "Installing ",
        pkg[i],
        "...",
        "\n"
      )
    )
    remotes::install_github(
      repo = pkg[i],
      lib = lib,
      quiet = TRUE
    )
  }
}
