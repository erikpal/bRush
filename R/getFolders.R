#' Get folders
#' 
#' Get a list of available reports
#' @param uri The base uri of a Canvas installation
#' @param ID The course, group, user or folder ID to return a list of folders of.
#' @param IDtype The type of ID ("course", "group", "user", or "folder")
#' @param folderID The ID of a folder if also providing a course or group ID.
#' @param path Character of path to folder
#' @param link Return vector of download location only.
#' @param ... Optional page options to pass to processRequest
#' @export
getFolders <- function(uri, ID, IDtype = "course", folderID = "", path = "", ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/TYPE/ID/folders")
       
        if (IDtype == "course") {
                urlbase <- sub("TYPE", "courses", urlbase)
        } else if (IDtype == "group") {
                urlbase <- sub("TYPE", "groups", urlbase)
        } else if (IDtype == "folder") {
                urlbase <- sub("TYPE", "folders", urlbase)
        } else if (IDtype == "user") {
                urlbase <- sub("TYPE", "users", urlbase)
        }
        
        urlbase <- sub("ID", ID, urlbase)
        
        if (!folderID == "" & !path == "") {
                stop("Please provide either folder ID or path, not both")
        } else if (!folderID == "") {
                urlbase <- paste0(urlbase, "/", folderID, "?")
        } else if (!path == "") {
                urlbase <- paste0(urlbase, "/by_path", path, "?")
        } else {
                urlbase <- paste0(urlbase, "?")
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}