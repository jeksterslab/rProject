#' Code Coverage
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @export
Coverage <- function(path) {
  lib <- LibPaths(path = path)
  installed <- utils::installed.packages()
  pkg_installed <- installed[, "Package"]
  if (!("covr" %in% pkg_installed)) {
    utils::install.packages(
      "covr",
      repos = c(REPO_NAME = PkgRepo(path = path)),
      lib = lib,
      quiet = TRUE
    )
  }
  covr::package_coverage(path = path)
}
