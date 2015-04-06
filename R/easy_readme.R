#' Get README file for a repo
#'
#' @export
#' @param repo (character) Repository name
#' @param branch (character) Git branch. Default: master
#' @param ... Further args to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' easy_readme(repo="sckott/testeasy")
#' }
easy_readme <- function(repo, branch = "master", ...) {
  pars <- parse_git_repo(repo)
  args <- ct(list(ref = branch))
  req <- httr::GET(sprintf("https://api.github.com/repos/%s/%s/readme", pars$username, pars$repo),
                    query = args, basic_auth(), ghead(), ...)
  structure(list(read_readme(httr::content(req)$content)), class = "readme")
}

read_readme <- function(x) {
  rawToChar(base64enc::base64decode(x))
}

#' @export
print.readme <- function(x, ...) {
  cat(x[[1]], sep = "\n")
}
