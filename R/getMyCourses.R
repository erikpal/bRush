#' Get self courses
#' 
#' Get course details for the account requesting.
#' @param type Filter results to include course with at least one of specified string ("teacher","student","ta","observer","designer")
#' @param role_id Integer of role ID to limit results.
#' @param state String of enrollment state to limit results to (“unpublished”,“available”,“completed”,“deleted”)
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getMyCourses <- function(type = NULL, role_id = NULL, state = NULL, server = "test", ...) {
        
        url <- loadURL(server)

        url$path <- "api/v1/courses"

        url$query <- list("include[]" = "needs_grading_count",
                          "include[]" = "syllabus_body",
                          "include[]" = "term",
                          "include[]" = "course_progress",
                          "include[]" = "sections",
                          "include[]" = "storage_quota_used_mb",
                          "include[]" = "total_students",
                          "include[]" = "passback_status",
                          "include[]" = "favorites",
                          "include[]" = "teachers",
                          "include[]" = "observed_users",
                          "include[]" = "total_scores",
                          enrollment_type = type,
                          enrollment_role_id = role_id,
                          "state[]" = state)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}