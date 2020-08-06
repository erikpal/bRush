#' Get submissions for a quiz
#' 
#' Get the submissions for the provided course and assignment.
#' @param courseID Course ID to find assignments for
#' @param quizID Assignmnet ID for the assignment to retreive a submission of
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getQuizSubmissions <- function(courseID, quizID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/courseID/quizzes/quizID/submissions"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("quizID", quizID, url$path)
        
        
        
        url$query <- list("include[]" = "submission",
                          "include[]" = "quiz",
                          "include[]" = "user")
        
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}