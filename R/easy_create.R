#' Create a file
#'
#' @export
#' @param x A data.frame
#' @param repo (character) Repository name. Required.
#' @param path (character) Path to file from root of repo. Required.
#' @param message (character) Commmit message. Required.
#' @param branch (character) Branch to use, Default: master
#' @param ... Curl options passed on to \code{\link[httr]{PUT}}
#' @examples \dontrun{
#' options(github_name = "Scott Chamberlain")
#' options(github_email = "myrmecocystus@@gmail.com")
#' easy_create(x=iris, repo = "sckott/testeasy", path ="iris.csv",
#'    message = "hello world")
#' }
easy_create <- function(x, repo, path, message, branch = "master", ...) {
  rest_PUT(x, repo, path, message, branch, ...)
}
