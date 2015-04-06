#' Create a file
#'
#' @export
#' @param repo (character) Repository name
#' @param path (character) Path to file from root of repo
#' @param message (character) Commmit message
#' @param branch (character) Branch to use
#' @param sha (character) The blob SHA of the file being replaced
#' @param ... Curl options passed on to \code{\link[httr]{PUT}}
#'
#' @examples \dontrun{
#' options(github_name = "Scott Chamberlain")
#' options(github_email = "myrmecocystus@@gmail.com")
#' rest_PUT(x=mtcars, repo = "ropensci/datasets", path ="mtcars.csv",
#'    message = "hello world")
#' }
rest_PUT <- function(x, repo, path, message, branch = "master", sha = NULL, ...) {
  pars <- parse_git_repo(repo)
  args <- ct(list(ref = branch))
  body <- list(
    message = message,
    committer = list(
      name = getOption("github_name"),
      email = getOption("github_email")
    ),
    content = unclass(RCurl::base64Encode(mtcars))
  )
  if (!is.null(sha)) body$sha <- sha
  req <- httr::PUT(make_new_url(pars$username, pars$repo, path),
                   query = args, body = jsonlite::toJSON(body, auto_unbox = TRUE),
                   basic_auth(), ghead())
  jsonlite::fromJSON(process(req), FALSE)
}
