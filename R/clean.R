#' Clean Files Generated on Build
#'
#' Delete all output files that are generated on automated build.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @export
Clean <- function(path) {
  # delete folders
  unlink(
    file.path(
      path,
      "doc"
    )
  )
  unlink(
    file.path(
      path,
      "docs"
    )
  )
  # delete files
  files <- file.path(
    path,
    c(
      "README.html",
      "README.md",
      "NAMESPACE"
    )
  )
  files <- c(
    files,
    list.files(
      file.path(
        path,
        "man"
      ),
      full.names = TRUE,
      recursive = TRUE,
      include.dirs = TRUE
    ),
    list.files(
      file.path(
        path,
        "latex",
        "pdf"
      ),
      full.names = TRUE,
      recursive = TRUE,
      include.dirs = TRUE
    ),
    list.files(
      file.path(
        path
      ),
      pattern = utils::glob2rx("fig-vignettes-*"),
      full.names = TRUE
    ),
    list.files(
      file.path(
        path,
        "vignettes"
      ),
      pattern = utils::glob2rx("fig-vignettes-*"),
      full.names = TRUE
    ),
    list.files(
      file.path(
        path,
        ".setup",
        "data-process"
      ),
      pattern = utils::glob2rx("*.Rds"),
      full.names = TRUE
    ),
    list.files(
      file.path(
        path
      ),
      pattern = utils::glob2rx("*.pdf"),
      full.names = TRUE
    )
  )
  unlink(files)
}
