#' Build Package
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @param vignettes Logical.
#'   Build vignettes.
#' @export
Build <- function(path,
                  vignettes = FALSE) {
  lib <- LibPaths(path = path)
  installed <- utils::installed.packages()
  pkg_installed <- installed[, "Package"]
  if (!("devtools" %in% pkg_installed)) {
    remotes::install_github(
      repo = "r-lib/devtools",
      lib = lib,
      quiet = TRUE
    )
  }
  devtools::document(pkg = path)
  devtools::check(pkg = path, cran = FALSE)
  devtools::install(pkg = path)
  devtools::build(
    pkg = path,
    path = path,
    manual = TRUE,
    vignettes = vignettes
  )
}
