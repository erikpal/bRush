#' Get custom gradebook columns from a course
#' 
#' Get custom gradebook columns for the provided course. Doesn't return assignment columns
#' @param courseID Course ID to gradebook columns
#' @param include_hidden Boolean to include hidden columns in request
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getGradebookColumns <- function(courseID, include_hidden = TRUE, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/custom_gradebook_columns"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list(include_hidden = include_hidden)

        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}