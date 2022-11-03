#' Knit `latexsrc/*.Rtex`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @export
LatexKnit <- function(path) {
  rtex_files <- list.files(
    file.path(
      path,
      "latexsrc"
    ),
    pattern = "\\.Rtex$",
    full.names = TRUE,
    all.files = TRUE
  )
  if (length(rtex_files) > 0) {
    lapply(
      X = rtex_files,
      FUN = function(i) {
        tex_file <- sub(
          pattern = "\\.Rtex$",
          replacement = "\\.tex",
          x = basename(i)
        )
        knitr::knit(
          input = i,
          output = file.path(
            Detritus(path = path)$tex_folder,
            tex_file
          )
        )
      }
    )
  }
}
