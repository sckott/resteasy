#' Github auth
#'
#' @export
#' @param appname Application name
#' @param key Application key
#' @param secret App secret key
#' @examples \dontrun{
#' github_auth()
#' }
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

# github_auth_old <- function(appname = getOption("gh_appname"), key = getOption("gh_id"),
#                         secret = getOption("gh_secret")) {
#   if (is.null(getOption("gh_token"))) {
#     myapp <- oauth_app(appname, key, secret)
#     token <- oauth2.0_token(oauth_endpoints("github"), myapp)
#     options(gh_token = token)
#   } else {
#     token <- getOption("gh_token")
#   }
#   return(token)
# }
