#' Get submissions for an assignment
#' 
#' Get the submissions for the provided course and assignment.
#' @param courseID Course ID to find assignments for
#' @param assignID Assignmnet ID for the assignment to retreive a submission of
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getSubmissions <- function(courseID, assignID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/courseID/assignments/assignID/submissions"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("assignID", assignID, url$path)

        
        
        url$query <- list("include[]" = "submission_history",
                          "include[]" = "submission_comments",
                          "include[]" = "rubric_assessment",
                          "include[]" = "visibility",
                          "include[]" = "course",
                          "include[]" = "assignment",
                          "include[]" = "group",
                          "include[]" = "user")
        
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}