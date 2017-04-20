#' Get files
#' 
#' Get a list of available reports
#' @param url The base url of a Canvas installation
#' @param ID The course, group, user, folder or specific file ID to return list for.
#' @param IDtype The type of ID ("course", "group", "user", "folder", "file")
#' @param fileID The ID of a file if getting a specific file.
#' @param term Character of search term to limit results
#' @param content Character of file type and or subtype pairs (e.g., 'image/jpeg' or 'image')
#' @param quota Boolean of whether this is a request for the file space quota
#' @param ... Optional page options to pass to processRequest
#' @export
getFiles <- function(url, ID, IDtype = "course", fileID = NULL,
                     search = NULL, content = NULL, quota = FALSE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "api/v1/TYPE/ID/files"

        if (IDtype == "course") {
                url$path <- sub("TYPE", "courses", url$path)
                url$path <- sub("ID", ID, url$path)
        } else if (IDtype == "group") {
                url$path <- sub("TYPE", "groups", url$path)
                url$path <- sub("ID", ID, url$path)
        } else if (IDtype == "folder") {
                url$path <- sub("TYPE", "folders", url$path)
                url$path <- sub("ID", ID, url$path)
        } else if (IDtype == "user") {
                url$path <- sub("TYPE", "users", url$path)
                url$path <- sub("ID", ID, url$path)
        } else if (IDtype == "file") {
                url$path <- sub("/TYPE/ID", "", url$path)
                url$path <- paste0(url$path, "/", ID)
        }
        
        ##Deal with some conflicting conditions
        if (IDtype == "folder" & quota == TRUE) {
                stop("Cannot get quota for a folder.")
        } else if (!is.null(fileID) & IDtype == "file") {
                stop("Cannot look up a specific file for a file ID.")
        }
        
        if (!is.null(fileID) & quota == TRUE) {
                stop("Please provide either file ID or set quota to true, not both.")
        } else if (IDtype == "file" & quota == TRUE){
                stop("Cannot get quota for a single file")
        }
        
        if (!is.null(fileID)) {
                url$path <- paste0(url$path, "/", fileID)
                url$query <- list("include[]" = "user")
        } else if (quota == TRUE) {
                url$path <- paste0(url$path, "/quota")
                url$query <- list(exclude = NULL)
        } else if (IDtype == "file") {
                url$query <- list("include[]" = "user")
        } else {
                url$query <- list("include[]" = "user",
                                search_term = search,
                                content_type = content)
                
        }
        
        if (!is.null(search)) {
                if (nchar(search) < 2) {
                        warning("Search term must be three or more characters.")
                }
        }

        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}