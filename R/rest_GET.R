#' Get a file
#'
#' @import httr
#' @export
#' @param repo (character) Repository name
#' @param path (character) Path to file from root of repo
#' @param branch (character) Git branch. Default: master
#' @param ... Further args to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' rest_GET(repo="ropensci/datasets", path="planttraits/morphological.csv")
#' rest_GET(repo="ropensci/datasets", path="mammals/mammals.csv")
#' rest_GET(repo="datasets/global-temp", path="data/annual.csv")
#' rest_GET("datasets/gold-prices", "data/data.csv")
#' rest_GET("datasets/gdp", "data/gdp.csv")
#'
#' rest_GET(repo = "sckott/testeasy", path = "mtcars.csv")
#' }
rest_GET <- function(repo, path, branch = "master", ...) {
  pars <- parse_git_repo(repo)
  args <- ct(list(ref = branch))
  req <- httr::GET(make_new_url(pars$username, pars$repo, path),
                   query = args, basic_auth(), ghead(), ...)
  txt <- jsonlite::fromJSON(process(req))$content
  read_file(txt)
}

read_file <- function(x) {
  read.csv(text = rawToChar(base64enc::base64decode(x)))
}

ghead <- function() add_headers(`Accept` = "application/vnd.github.v3+json")

