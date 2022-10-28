#' Copy Dependencies to from `.setup/r-dependencies` to `R`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @export
Dependencies <- function(path) {
  deps <- list.files(
    path = file.path(
      path,
      ".setup",
      "r-dependencies"
    ),
    pattern = "\\.R$",
    full.names = TRUE,
    all.files = TRUE,
    recursive = TRUE
  )
  if (length(deps) > 0) {
    file.copy(
      from = deps,
      to = file.path(
        path,
        "R"
      ),
      overwrite = TRUE
    )
  }
}
