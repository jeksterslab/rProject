#' Compile Output of `LatexKnit`
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams LibPaths
#' @param clean Logical.
#'   Clean `latexmk` output except `*.pdf`
#' @export
LatexCompile <- function(path,
                         clean = FALSE) {
  detritus <- Detritus(path = path)
  tex_folder <- detritus$tex_folder
  pdf_folder <- file.path(
    path,
    "latexsrc",
    "pdf"
  )
  dir.create(
    pdf_folder,
    showWarnings = FALSE,
    recursive = TRUE
  )
  dot_gitignore_file <- file.path(
    pdf_folder,
    ".gitignore"
  )
  if (!file.exists(dot_gitignore_file)) {
    dot_gitignore <- c(
      "*",
      "*/",
      "!*.pdf",
      "!.gitignore"
    )
    con <- file(dot_gitignore_file)
    writeLines(
      text = dot_gitignore,
      con = con,
      sep = "\n"
    )
    close(con)
  }
  try(
    system(
      paste0(
        "latexmk -f -pdf -interaction=nonstopmode -output-directory=",
        pdf_folder,
        " ",
        paste0(
          tex_folder,
          "/*.tex"
        )
      )
    )
  )
  if (clean) {
    invisible(
      lapply(
        X = c(
          "\\.tex$",
          "\\.xml$",
          "\\.out$",
          "\\.log$",
          "\\.fls$",
          "\\.fdb_latexmk$",
          "\\.ent$",
          "\\.blg$",
          "\\.bcf$",
          "\\.bbl$",
          "\\.aux$"
        ),
        FUN = function(x) {
          invisible(
            lapply(
              X = list.files(
                pdf_folder,
                pattern = x,
                full.names = TRUE,
                all.files = TRUE
              ),
              FUN = unlink
            )
          )
        }
      )
    )
    unlink(
      paste0(
        tex_folder,
        "/tex-fig-*"
      ),
      recursive = TRUE
    )
  }
}
