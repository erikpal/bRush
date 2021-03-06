% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getRubric.R
\name{getRubric}
\alias{getRubric}
\title{Get a single rubric from an account or course}
\usage{
getRubric(ID, rubricID = "", type = "account", server = "test", ...)
}
\arguments{
\item{ID}{Integer of the account ID to find users for}

\item{rubricID}{ID of the specific rubric}

\item{type}{Course or account}

\item{server}{Test, beta, production, or other name in R.environ OR full url of server}

\item{...}{Optional page options to pass to processRequest}
}
\description{
Get a single rubric from an account or course
}
