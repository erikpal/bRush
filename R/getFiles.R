#' Get files
#' 
#' Get a list of available reports
#' @param uri The base uri of a Canvas installation
#' @param ID The course, group, user, folder or specific file ID to return list for.
#' @param IDtype The type of ID ("course", "group", "user", "folder", "file")
#' @param fileID The ID of a file if getting a specific file.
#' @param term Character of search term to limit results
#' @param content Character of file type and or subtype pairs (e.g., 'image/jpeg' or 'image')
#' @param quota Boolean of whether this is a request for the file space quota
#' @param ... Optional page options to pass to processRequest
#' @export
getFiles <- function(uri, ID, IDtype = "course", fileID = "",
                     search = "", content = "", quota = FALSE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/TYPE/ID/files")
        
        if (IDtype == "course") {
                urlbase <- sub("TYPE", "courses", urlbase)
                urlbase <- sub("ID", ID, urlbase)
        } else if (IDtype == "group") {
                urlbase <- sub("TYPE", "groups", urlbase)
                urlbase <- sub("ID", ID, urlbase)
        } else if (IDtype == "folder") {
                urlbase <- sub("TYPE", "folders", urlbase)
                urlbase <- sub("ID", ID, urlbase)
        } else if (IDtype == "user") {
                urlbase <- sub("TYPE", "users", urlbase)
                urlbase <- sub("ID", ID, urlbase)
        } else if (IDtype == "file") {
                urlbase <- sub("/TYPE/ID", "", urlbase)
                urlbase <- paste0(urlbase, "/", ID, "?")
        }
        
        
        if (IDtype == "folder" & quota == TRUE) {
                stop("Cannot get quota for a folder.")
        } else if (!fileID == "" & IDtype == "file") {
                stop("Cannot look up a specific file for a file ID.")
        }
        
        if (!fileID == "" & quota == TRUE) {
                stop("Please provide either file ID or set quota to true, not both.")
        } else if (IDtype == "file" & quota == TRUE){
                stop("Cannot get quota for a single file")
        }
        
        if (!fileID == "") {
                urlbase <- paste0(urlbase, "/", fileID, "?")
                urlbase <- paste0(urlbase, "include[]=user")
        } else if (quota == TRUE) {
                urlbase <- paste0(urlbase, "/quota", path, "?")
        } else if (IDtype == "file") {
                urlbase <- paste0(urlbase, "include[]=user")
        } else {
                urlbase <- paste0(urlbase, "?")
                urlbase <- paste0(urlbase, "include[]=user")
                urlbase <- paste0(urlbase, "search_term=", search)
                urlbase <- paste0(urlbase, "content_type=", content)
                
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}