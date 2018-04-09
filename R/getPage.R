#' Get a specific page
#' 
#' Get a list of pages in course or group.
#' @param courseID Course or group ID of page
#' @param pageID Page ID number or title
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getPage <- function(courseID, pageID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/pages/pageID"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("pageID", pageID, url$path)
        
        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}