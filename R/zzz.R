ct <- function(l) Filter(Negate(is.null), l)

make_url <- function(owner, repo, branch = "master", path) {
  file.path("https://raw.githubusercontent.com", owner, repo, branch, path)
}

make_new_url <- function(owner, repo, path) {
  file.path("https://api.github.com/repos", owner, repo, "contents", path)
}

process_result <- function(x) {
  httr::stop_for_status(x)
  tmp <- httr::content(x, as = "text")
  read.csv(text = tmp, stringsAsFactors = FALSE)
}

process <- function(x) {
  httr::stop_for_status(x)
  httr::content(x, as = "text")
}

parse_git_repo <- function(path) {
  username_rx <- "(?:([^/]+)/)?"
  repo_rx <- "([^/@#]+)"
  subdir_rx <- "(?:/([^@#]*[^@#/]))?"
  ref_rx <- "(?:@([^*].*))"
  pull_rx <- "(?:#([0-9]+))"
  release_rx <- "(?:@([*]release))"
  ref_or_pull_or_release_rx <- sprintf("(?:%s|%s|%s)?", ref_rx,
                                       pull_rx, release_rx)
  github_rx <- sprintf("^(?:%s%s%s%s|(.*))$", username_rx,
                       repo_rx, subdir_rx, ref_or_pull_or_release_rx)
  param_names <- c("username", "repo", "subdir", "ref", "pull",
                   "release", "invalid")
  replace <- setNames(sprintf("\\%d", seq_along(param_names)),
                      param_names)
  params <- lapply(replace, function(r) gsub(github_rx, r,
                                             path, perl = TRUE))
  if (params$invalid != "")
    stop(sprintf("Invalid git repo: %s", path))
  params <- params[sapply(params, nchar) > 0]
  if (!is.null(params$pull)) {
    params$ref <- github_pull(params$pull)
    params$pull <- NULL
  }
  if (!is.null(params$release)) {
    params$ref <- github_release()
    params$release <- NULL
  }
  params
}

github_pull <- function(pull) structure(pull, class = "github_pull")
github_release <- function() structure(NA_integer_, class = "github_release")

c2api_url <- function() "http://labs.data.gov/csv-to-api"
