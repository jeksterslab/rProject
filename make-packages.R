#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)
path <- as.character(args[1])
source(
  file.path(
    path,
    ".project"
  )
)
rProject::PkgDevel(
  path = path
)
rProject::PkgDevelGitHub(
  path = path
)
rProject::PkgProject(
  path = path,
  pkg = pkg_cran
)
rProject::PkgProjectGitHub(
  path = path,
  pkg = pkg_github
)
rProject::PkgProjectVersion(
  path = path,
  pkg = pkg_ver,
  ver = ver
)
