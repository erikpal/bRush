#' Get folders
#' 
#' Get a list of available reports
#' @param url The base url of a Canvas installation
#' @param ID The course, group, user or folder ID to return a list of folders of.
#' @param IDtype The type of ID ("course", "group", "user", or "folder")
#' @param folderID The ID of a folder if also providing a course or group ID.
#' @param path Character of path to folder
#' @param ... Optional page options to pass to processRequest
#' @export
getFolders <- function(url, ID, IDtype = "course", 
                       folderID = NULL, path = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
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
        
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}