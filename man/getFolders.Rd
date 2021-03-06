% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getFolders.R
\name{getFolders}
\alias{getFolders}
\title{Get folders}
\usage{
getFolders(
  ID,
  IDtype = "course",
  folderID = NULL,
  path = NULL,
  server = "test",
  ...
)
}
\arguments{
\item{ID}{The course, group, user or folder ID to return a list of folders of.}

\item{IDtype}{The type of ID ("course", "group", "user", or "folder")}

\item{folderID}{The ID of a folder if also providing a course or group ID.}

\item{path}{Character of path to folder}

\item{server}{Test, beta, production, or other name in R.environ OR full url of server}

\item{...}{Optional page options to pass to processRequest}
}
\description{
Get a list of folders for the provided, course, group, or user.
}
