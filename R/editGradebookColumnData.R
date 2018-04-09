#' Create/edit a custom grade book column data entry for user in a course
#' 
#' Create/edit a new custom grade book column entry for the provided user and course.
#' @param courseID Course ID with the custom column
#' @param columnID ID of of the column
#' @param userID ID of the user (student) to write column datum to
#' @param include_hidden Character of the content to place in the column for user
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
editGradebookColumnData <- function(courseID, columnID, userID, 
                                    content, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/COURSEID/custom_gradebook_columns/COLID/data/USERID"
        url$path <- sub("COURSEID", courseID, url$path)
        url$path <- sub("COLID", columnID, url$path)
        url$path <- sub("USERID", userID, url$path)
        
        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list(
                column_data = list(
                        content = content
                )
        )
        body <- toJSON(body, auto_unbox = TRUE)

        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "EDIT", ...)
        
        return(results)
}