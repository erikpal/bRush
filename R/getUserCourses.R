#' Get courses for a user
#' 
#' Get course details for the account requesting. All include parameters (see API
#' documentation) for this request have all been enabled and can be subsetted out 
#' if not needed.
#' @param userID The string of a user to request courses of
#' @param state String of enrollment state to limit results to (unpublished, available, completed, deleted)
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getUserCourses <- function(userID, state = NULL, server = "test", ...) {
        
        url <- loadURL(server)

        url$path <- "api/v1/users/userID/courses"
        url$path <- sub("userID", userID, url$path)
        
        url$query <- list("include[]" = "needs_grading_count",
                          "include[]" = "syllabus_body",
                          "include[]" = "term",
                          "include[]" = "course_progress",
                          "include[]" = "sections",
                          "include[]" = "storage_quota_used_mb",
                          "include[]" = "total_students",
                          "include[]" = "favorites",
                          "include[]" = "total_scores",
                          "state[]" = state)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}