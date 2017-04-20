#' Get custom grade book column data for a course
#' 
#' Get custom grade book column entry for the provided user and course.
#' @param url The base url of a Canvas installation
#' @param courseID Course ID with the custom column
#' @param columnID ID of of the column
#' @param include_hidden Boolean to include hidden columns in request
#' @param ... Optional page options to pass to processRequest
#' @export
getGradebookColumnData <- function(url, courseID, columnID, include_hidden = TRUE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "/api/v1/courses/COURSEID/custom_gradebook_columns/COLID/data"
        url$path <- sub("COURSEID", courseID, url$path)
        url$path <- sub("COLID", columnID, url$path)
        
        url$query <- list(include_hidden = include_hidden)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}