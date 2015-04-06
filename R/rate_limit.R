#' Rate limit
#' @export
#' @param ... Further args to \code{\link[httr]{GET}}
#' @examples \dontrun{
#' rate_limit()
#' }
rate_limit <- function(...) {
  req <- httr::GET("https://api.github.com/rate_limit", make_auth(), ...)
  structure(jsonlite::fromJSON(process(req)), class = "gh_rate")
}

#' @export
print.gh_rate <- function(x, ...){
  cat("Rate limit: ", x$rate$limit, '\n', sep = "")
  cat("Remaining:  ", x$rate$remaining, '\n', sep = "")
  diff <- difftime(as.POSIXct(x$rate$reset, origin = "1970-01-01"), Sys.time(), units = "secs")
  cat("Resets in:  ", time(diff), "\n", sep = "")
}

time <- function(x) {
  x <- as.integer(x)

  if (x > 3600) {
    paste0(x %/% 3600, " hours")
  } else if (x > 300) {
    paste0(x %/% 60, " minutes")
  } else if (x > 60) {
    paste0(round(x / 60, 1), " minutes")
  } else {
    paste0(x, "s")
  }
}
