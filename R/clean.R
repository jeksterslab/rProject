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
      "man"
    )
  )
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
  unlink(
    file.path(
      path,
      "TEMPDIR"
    )
  )
  unlink(
    file.path(
      path,
      "latex",
      "pdf"
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
        path
      ),
      pattern = utils::glob2rx("fig-vignettes-*"),
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
