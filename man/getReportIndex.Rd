% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getReportIndex.R
\name{getReportIndex}
\alias{getReportIndex}
\title{Get list of an index of reports available by report type}
\usage{
getReportIndex(accountID, report_type, server = "test", ...)
}
\arguments{
\item{accountID}{The account ID to retrieve reports from}

\item{report_type}{The report identifier (e.g., outcome_results_csv)}

\item{server}{Test, beta, production, or other name in R.environ OR full url of server}

\item{...}{Optional page options to pass to processRequest}
}
\description{
Get a list of available reports, with extra options to select just a report download url.
}
