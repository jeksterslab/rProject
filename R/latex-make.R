#' Compile Output of `LatexKnit`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LatexCompile
#' @export
LatexMake <- function(path,
                      clean = FALSE) {
  try(
    LatexKnit(
      path = path
    )
  )
  try(
    LatexCompile(
      path = path,
      clean = clean
    )
  )
}
