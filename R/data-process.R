#' Process Data
#'
#' Execute R scripts in `data-process`.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @param clean Logical.
#'   Remove all `.Rds` files in `data-process` before running.
#' @export
DataProcess <- function(path,
                        clean = FALSE) {
  if (clean) {
    x <- list.files(
      path = file.path(
        path,
        "data-process"
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
      "data-process"
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
