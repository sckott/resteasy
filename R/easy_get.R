#' Get a file with query parameters
#'
#' @importFrom dplyr rbind_all as_data_frame tbl_df
#' @export
#' @param repo (character) Repository name
#' @param path (character) Path to file from root of repo
#' @param branch (character) Branch to use, Default: master
#' @param curlopts Curl options passed on to \code{\link[httr]{GET}}
#' @param ... Further args to sort or filter
#'
#' @details You can sort and filter by column names. Pass in key/value pairs
#' to either sort of filter on.
#' @examples \dontrun{
#' rest_GET(repo = "datasets/gdp", path ="data/gdp.csv")
#' rest_GET("datasets/gdp", "data/gdp.csv", Year = 2000)
#'
#' rest_GET(repo="ropensci/datasets", "mammals/mammals.csv")
#' easy_get(repo="ropensci/datasets", path="mammals/mammals.csv")
#' easy_get("ropensci/datasets", "mammals/mammals.csv", Family="Coryphodontidae")
#' easy_get("ropensci/datasets", "mammals/mammals.csv", Last_appearance_mya=50)
#' }
easy_get <- function(repo, path, branch = "master", curlopts = list(), ...) {
  pars <- parse_git_repo(repo)
  dat <- make_url(pars$username, pars$repo, branch, path)
  args <- ct(list(source = dat, ...))
  if (all(names(args) == "source")) {
    tmp <- rest_GET(repo, path, branch, curlopts, ...)
  } else {
    req <- httr::GET(c2api_url(), query = args, curlopts)
    tmp <- jsonlite::fromJSON(process(req))
  }
  if (is(tmp, "data.frame")) {
    return(tbl_df(tmp))
  } else {
    rbind_all(lapply(tmp, as_data_frame))
  }
}
