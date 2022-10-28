#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
path <- as.character(args[1])
source(
  file.path(
    path,
    ".project"
  )
)
source(
  file.path(
    path,
    ".secrets"
  )
)
dot_library_folder <- file.path(
  path,
  ".library"
)
dir.create(
  dot_library_folder,
  showWarnings = FALSE,
  recursive = TRUE
)
dot_gitignore_file <- file.path(
  dot_library_folder,
  ".gitignore"
)
if (!file.exists(dot_gitignore_file)) {
  dot_gitignore <- c(
    "*",
    "*/"
  )
  con <- file(dot_gitignore_file)
  writeLines(
    text = dot_gitignore,
    con = con,
    sep = "\n"
  )
  close(con)
}
.libPaths(
  dot_library_folder
)
Sys.setenv(
  R_LIBS_USER = dot_library_folder
)
installed <- installed.packages()
pkg_installed <- installed[, "Package"]
if (!("remotes" %in% pkg_installed)) {
  install.packages(
    "remotes",
    repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/latest"),
    lib = ".library",
    quiet = TRUE
  )
}
if (!("rProject" %in% pkg_installed)) {
  remotes::install_github(
    "jeksterslab/rProject",
    quiet = TRUE
  )
}
rProject::Project(
  path = path
)
rProject::Profile(
  path = path,
  project = project
)
rProject::Environment(
  path = path,
  project = project,
  secrets = secrets
)
rProject::BuildIgnore(
  path = path,
  project = project,
  add = ignore
)
rProject::Binary(
  path = path
)
