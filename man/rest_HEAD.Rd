% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/rest_HEAD.R
\name{rest_HEAD}
\alias{rest_HEAD}
\title{Get head content}
\usage{
rest_HEAD(repo, path, branch = "master", ...)
}
\arguments{
\item{repo}{(character) Repository name}

\item{path}{(character) Path to file from root of repo}

\item{branch}{(character) Git branch. Default: master}

\item{...}{Further args to \code{\link[httr]{GET}}}
}
\description{
Get head content
}
\examples{
\dontrun{
rest_HEAD(repo="ropensci/datasets", path="planttraits/morphological.csv")
}
}

