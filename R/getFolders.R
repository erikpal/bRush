#' Get folders
#' 
#' Get a list of folders for the provided, course, group, or user.
#' @param ID The course, group, user or folder ID to return a list of folders of.
#' @param IDtype The type of ID ("course", "group", "user", or "folder")
#' @param folderID The ID of a folder if also providing a course or group ID.
#' @param path Character of path to folder
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export


getFolders <- function(ID, IDtype = "course", 
                       folderID = NULL, path = NULL, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/TYPE/ID/folders"
        
        if (IDtype == "course") {
                url$path <- sub("TYPE", "courses", url$path)
        } else if (IDtype == "group") {
                url$path <- sub("TYPE", "groups", url$path)
        } else if (IDtype == "folder") {
                url$path <- sub("TYPE", "folders", url$path)
        } else if (IDtype == "user") {
                url$path <- sub("TYPE", "users", url$path)
        }
        
        url$path <- sub("ID", ID, url$path)
        
        if (!is.null(folderID) & !is.null(path)) {
                stop("Please provide either folder ID or path, not both")
        } else if (!is.null(folderID)) {
                url$path <- paste0(url$path, "/", folderID)
                url$query <- list(exclude = NULL)
        } else if (!is.null(path)) {
                url$path <- paste0(url$path, "/by_path", path)
                url$query <- list(exclude = NULL)
        } else {
                url$query <- list(exclude = NULL)
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}