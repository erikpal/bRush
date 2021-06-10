#' Get aligned assignments for an outcome in a course for a particular student 
#' 
#' Get a list of outcomes in a course or account.
#' @param courseID Course ID
#' @param studentID Student ID
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getOutcomeStudent <- function(courseID, studentID, 
                              type = "account", server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/COURSEID/outcome_alignments?student_id=STUDENTID"
        url$path <- sub("COURSEID", courseID, url$path)
        url$path <- sub("STUDENTID", studentID, url$path)
        
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}