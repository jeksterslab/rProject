#' Install Project Packages with Specific Version
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @param pkg Character vector.
#'   R packages.
#' @param ver Character vector.
#'   Version.
#' @export
PkgProjectVersion <- function(path,
                              pkg,
                              ver) {
  stopifnot(length(pkg) == length(ver))
  lib <- LibPaths(path = path)
  installed <- utils::installed.packages()
  pkg_installed <- installed[, "Package"]
  repos <- c(REPO_NAME = PkgRepo(path = path))
  if (!("remotes" %in% pkg_installed)) {
    utils::install.packages(
      "remotes",
      repos = repos,
      lib = lib,
      quiet = TRUE
    )
  }
  if (length(pkg) > 0) {
    stopifnot(length(pkg) == length(ver))
    for (i in seq_along(pkg)) {
      cat(
        paste0(
          "Installing ",
          pkg[i],
          " ",
          ver[i],
          "...",
          "\n"
        )
      )
      remotes::install_version(
        package = pkg[i],
        version = ver[i],
        repos = repos,
        lib = lib,
        quiet = TRUE
      )
    }
  }
}
