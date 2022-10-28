#' Package Manual
#'
#' @inheritParams LibPaths
#' @inheritParams EnvironmentProject
#' @export
Manual <- function(path,
                   project) {
  unlink(
    file.path(
      path,
      paste0(project, "pdf")
    )
  )
  system(
    paste(
      shQuote(
        file.path(
          R.home("bin"),
          "R"
        )
      ),
      "CMD",
      "Rd2pdf",
      shQuote(
        find.package(project)
      )
    )
  )
}
