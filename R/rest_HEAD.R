#' Get head content
#'
#' @export
#' @param repo (character) Repository name
#' @param path (character) Path to file from root of repo
#' @param branch (character) Git branch. Default: master
#' @param ... Further args to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' rest_HEAD(repo="ropensci/datasets", path="planttraits/morphological.csv")
#' }
rest_HEAD <- function(repo, path, branch = "master", ...) {
  pars <- parse_git_repo(repo)
  args <- ct(list(ref = branch))
  req <- httr::HEAD(make_new_url(pars$username, pars$repo, path),
                   query = args, basic_auth(), ghead(), ...)
  structure(req$headers, class = "resthead")
}

#' @export
print.resthead <- function(x, ...) {
  for (i in seq_along(x)) {
    cat(paste0(names(x[i]), ": ", x[[i]]), sep = "\n")
  }
}
