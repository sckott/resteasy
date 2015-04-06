#' Delete a file
#'
#' @export
#' @param repo (character) Repository name
#' @param path (character) Path to file from root of repo
#' @param branch (character) Git branch. Default: master
#' @param ... Further args to \code{\link[httr]{DELETE}}
#' @examples \dontrun{
#' rest_DELETE(repo = "ropensci/datasets", path = "mtcars.csv",
#'    message = "deleting file")
#' }
rest_DELETE <- function(repo, path, message, sha = NULL, branch = "master", ...) {
  pars <- parse_git_repo(repo)
  args <- ct(list(ref = branch, message = message,
                  sha = get_sha(sha, repo, path, branch)))
  req <- httr::DELETE(make_new_url(pars$username, pars$repo, path),
                      query = args, basic_auth(), ghead(), ...)
  content(req)
}
