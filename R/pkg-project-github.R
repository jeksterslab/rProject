#' Install Project Packages from GitHub
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @param pkg Character vector.
#'   GitHub packages.
#' @export
PkgProjectGitHub <- function(path,
                             pkg) {
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
