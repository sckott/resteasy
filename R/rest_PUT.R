#' Create a file
#'
#' @import base64enc
#' @export
#' @param x A data.frame
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
#'
#' # From a data.frame
#' row.names(mtcars) <- NULL
#' rest_PUT(mtcars, repo = "sckott/testeasy", path = "mtcars.csv",
#'    message = "putting up mtcars, from a data.frame")
#'
#' # From a file
#' write.csv(mtcars, file="~/mtcars.csv")
#' rest_PUT("~/mtcars.csv", repo = "sckott/testeasy", path = "mtcars.csv",
#'    message = "putting up mtcars, from a file")
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
    content = make_base64(x)
  )
  if (!is.null(sha)) body$sha <- sha
  req <- httr::PUT(make_new_url(pars$username, pars$repo, path),
                   query = args, body = jsonlite::toJSON(body, auto_unbox = TRUE),
                   basic_auth(), ghead())
  jsonlite::fromJSON(process(req), FALSE)
}

make_base64 <- function(x) {
  UseMethod("make_base64")
}

make_base64.data.frame <- function(x) {
  tfile <- tempfile()
  write.csv(x, file = tfile)
  base64enc::base64encode(tfile)
}

make_base64.character <- function(x) {
  stopifnot(file.exists(x))
  base64enc::base64encode(x)
}
