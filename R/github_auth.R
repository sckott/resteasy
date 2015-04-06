github_pat <- function() {
  pat <- Sys.getenv("GITHUB_PAT")
  if (identical(pat, ""))
    return(NULL)
  message("Using github PAT from envvar GITHUB_PAT")
  pat
}

make_auth <- function() {
  ga <- github_pat()
  if (!is.null(ga)) {
    httr::add_headers(Authorization = sprintf("token %s", github_pat()))
  } else {
    NULL
  }
}

basic_auth <- function() {
  user <- getOption("github.username")
  pwd <- getOption("github.password")
  if (!is.null(user) && !is.null(pwd)) {
    httr::authenticate(user, pwd)
  } else {
    NULL
  }
}
