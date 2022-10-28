#' Setup `.Renviron`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @inheritParams EnvironmentProject
#' @inheritParams EnvironmentSecrets
#' @export
Environment <- function(path,
                        project,
                        secrets) {
  dot_rprofile_file <- file.path(
    path,
    ".Rprofile"
  )
  Sys.setenv(R_PROFILE_USER = dot_rprofile_file)
  dot_rhistory_file <- file.path(
    path,
    ".Rhistory"
  )
  Sys.setenv(R_HISTFILE = dot_rhistory_file)
  key <- c(
    "R_LIBS_USER",
    "R_PROFILE_USER",
    "R_HISTFILE"
  )
  value <- c(
    paste0("\"", LibPaths(path = path), "\""),
    paste0("\"", dot_rprofile_file, "\""),
    paste0("\"", dot_rhistory_file, "\"")
  )
  dot_renviron_contents <- paste(
    key,
    value,
    sep = "="
  )
  dot_renviron_contents <- c(
    dot_renviron_contents,
    "R_COMPLETION=TRUE"
  )
  secrets <- EnvironmentSecrets(secrets = secrets)
  secrets <- paste0(
    names(secrets),
    "=",
    "\"",
    unname(secrets),
    "\""
  )
  dot_renviron_contents <- c(
    dot_renviron_contents,
    secrets
  )
  project <- EnvironmentProject(project = project)
  project <- paste0(
    names(project),
    "=",
    "\"",
    unname(project),
    "\""
  )
  dot_renviron_contents <- c(
    dot_renviron_contents,
    project
  )
  dot_renviron_file <- file.path(
    path,
    ".Renviron"
  )
  con <- file(dot_renviron_file)
  writeLines(
    text = dot_renviron_contents,
    con = con,
    sep = "\n"
  )
  close(con)
}
