#' Delete or inactivate an enrollment
#' 
#' Get user details for the provided user id. NOTE: Returns a list.
#' @param courseID Course ID of enrollment
#' @param userID User ID of enrollment
#' @param task One of "conclude", "delete", "inactivate", "deactivate"
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export

deleteEnrollment <- function(courseID, userID, task = "delete", server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/courseID/enrollments/userID"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("userID", userID, url$path)
        
        url$query <- list("task" = task)
        
        ##Pass the url to the request processor
        results <- processRequest(url, method = "DELETE", ...)
        
        return(results)
}