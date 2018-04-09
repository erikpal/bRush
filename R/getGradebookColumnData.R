#' Get custom grade book column data for a course
#' 
#' Get custom grade book column entry for the course.
#' @param courseID Course ID with the custom column
#' @param columnID ID of of the column
#' @param include_hidden Boolean to include hidden columns in request
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getGradebookColumnData <- function(courseID, columnID, 
                                   include_hidden = TRUE, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/COURSEID/custom_gradebook_columns/COLID/data"
        url$path <- sub("COURSEID", courseID, url$path)
        url$path <- sub("COLID", columnID, url$path)
        
        url$query <- list(include_hidden = include_hidden)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}