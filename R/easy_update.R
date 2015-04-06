#' Update a file
#'
#' @export
#' @param repo (character) Repository name. Required.
#' @param path (character) Path to file from root of repo. Required.
#' @param message (character) Commmit message. Required.
#' @param branch (character) Branch to use, Default: master
#' @param ... Curl options passed on to \code{\link[httr]{PUT}}
#' @examples \dontrun{
#' options(github_name = "Scott Chamberlain")
#' options(github_email = "myrmecocystus@@gmail.com")
#' easy_create(iris, repo = "sckott/testeasy", path = "iris.csv",
#'    message = "hello world")
#' easy_update(iris[1:5,], repo = "sckott/testeasy", path = "iris.csv",
#'    message = "changes to iris file")
#' }
easy_update <- function(x, repo, path, message, branch = "master", ...) {
  sha <- get_sha(repo = repo, path = path, branch = branch)
  rest_PUT(x, repo, path, message, branch, sha = sha, ...)
}

get_sha <- function(sha = NULL, repo, path, branch = "master") {
  if (!is.null(sha)) {
    return(sha)
  } else {
    tmp <- get_raw(repo, path, branch = "master")
    return(tmp$sha)
  }
}

get_raw <- function(repo, path, branch = "master", ...) {
  pars <- parse_git_repo(repo)
  args <- ct(list(ref = branch))
  req <- httr::GET(make_new_url(pars$username, pars$repo, path),
                   query = args, basic_auth(), ghead(), ...)
  jsonlite::fromJSON(process(req), FALSE)
}
