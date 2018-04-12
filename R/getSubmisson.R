#' Get submission for an assignment
#' 
#' Get the details of a specific submission for the provided course, assignment and user IDs.
#' @param courseID Course ID to find assignments for
#' @param assignID Assignmnet ID for the assignment to retreive a submission of
#' @param userID User ID to retreive assignment submission for
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getSubmission <- function(courseID, assignID, userID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/courseID/assignments/assignID/submissions/userID"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("assignID", assignID, url$path)
        url$path <- sub("userID", userID, url$path)
        
        
        
        url$query <- list("include[]" = "submission_history",
                          "include[]" = "submission_comments",
                          "include[]" = "rubric_assessment",
                          "include[]" = "visibility",
                          "include[]" = "course",
                          "include[]" = "user")
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}