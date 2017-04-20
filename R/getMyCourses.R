#' Get self courses
#' 
#' Get course details for the account requesting. All include parameters (see API
#' documentation) for this request have all been enabled and can be subsetted out 
#' if not needed.
#' @param url The base url of a Canvas installation
#' @param type Filter results to include course with at least one of specified string ("teacher","student","ta","observer","designer")
#' @param role_id Integer of role ID to limit results.
#' @param state String of enrollment state to limit results to (“unpublished”,“available”,“completed”,“deleted”)
#' @param ... Optional page options to pass to processRequest
#' @export
getMyCourses <- function(url, type = NULL, role_id = NULL, state = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
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