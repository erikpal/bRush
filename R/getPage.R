#' Get a specific page
#' 
#' Get a list of pages in course or group.
#' @param url The base url of a Canvas installation
#' @param courseID Course or group ID of page
#' @param pageID Page ID number
#' @param ... Optional page options to pass to processRequest
#' @export
getPage <- function(url, courseID, pageID, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/pages/pageID"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("pageID", pageID, url$path)
        
        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}