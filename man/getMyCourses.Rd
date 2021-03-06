% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getMyCourses.R
\name{getMyCourses}
\alias{getMyCourses}
\title{Get self courses}
\usage{
getMyCourses(type = NULL, role_id = NULL, state = NULL, server = "test", ...)
}
\arguments{
\item{type}{Filter results to include course with at least one of specified string ("teacher","student","ta","observer","designer")}

\item{role_id}{Integer of role ID to limit results.}

\item{state}{String of enrollment state to limit results to (unpublished, available, completed, deleted)}

\item{server}{Test, beta, prodcution, OR alternative name in R.environ OR url of server}

\item{...}{Optional page options to pass to processRequest}
}
\description{
Get course details for the account requesting.
}
