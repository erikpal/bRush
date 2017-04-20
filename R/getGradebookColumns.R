#' Get custom gradebook columns from a course
#' 
#' Get custom gradebook columns for the provided course. 
#' @param url The base url of a Canvas installation
#' @param courseID Course ID to gradebook columns
#' @param include_hidden Boolean to include hidden columns in request
#' @param ... Optional page options to pass to processRequest
#' @export
getGradebookColumns <- function(url, courseID, include_hidden = TRUE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/custom_gradebook_columns"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list(include_hidden = include_hidden)

        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}