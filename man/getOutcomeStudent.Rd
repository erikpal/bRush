% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getOutcomeStudent.R
\name{getOutcomeStudent}
\alias{getOutcomeStudent}
\title{Get aligned assignments for an outcome in a course for a particular student}
\usage{
getOutcomeStudent(courseID, studentID, type = "account", server = "test", ...)
}
\arguments{
\item{courseID}{Course ID}

\item{studentID}{Student ID}

\item{server}{Test, beta, production, or other name in R.environ OR full url of server}

\item{...}{Optional page options to pass to processRequest}
}
\description{
Get a list of outcomes in a course or account.
}
