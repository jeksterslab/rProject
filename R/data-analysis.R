#' Data Analysis
#'
#' Execute R scripts in `data-analysis`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @param clean Logical.
#'   Remove all `.Rds` files in `data-process`
#'   and `data-analysis` before running.
#' @export
DataAnalysis <- function(path,
                         clean = FALSE) {
  DataProcess(
    path = path,
    clean = clean
  )
  if (clean) {
    x <- list.files(
      path = file.path(
        path,
        ".data-analysis"
      ),
      pattern = "\\.Rds$",
      full.names = TRUE,
      all.files = TRUE,
      recursive = TRUE
    )
    if (length(x) > 0) {
      unlink(x)
    }
  }
  x <- list.files(
    path = file.path(
      path,
      ".data-analysis"
    ),
    pattern = "\\.R$",
    full.names = TRUE,
    all.files = TRUE,
    recursive = TRUE
  )
  if (length(x) > 0) {
    invisible(
      lapply(
        X = x,
        FUN = source
      )
    )
  }
}
