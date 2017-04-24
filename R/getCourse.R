#' Get a single course
#' 
#' Get details of a single course
#' @param url The base url of a Canvas installation
#' @param courseID The base url of a Canvas installation
#' @param ... Optional page options to pass to processRequest
#' @export
getCourse <- function(url, courseID, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "/api/v1/courses/courseID"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list("include[]" = "needs_grading_count", 
                          "include[]" = "syllabus_body",
                          "include[]" = "public_description",
                          "include[]" = "total_scores",
                          "include[]" = "current_grading_period_scores",
                          "include[]" = "term",
                          "include[]" = "course_progress",
                          "include[]" = "sections",
                          "include[]" = "storage_quota_used_mb",
                          "include[]" = "total_students",
                          "include[]" = "passback_status",
                          "include[]" = "favorites",
                          "include[]" = "teachers",
                          "include[]" = "observed_users",
                          "include[]" = "all_courses",
                          "include[]" = "permissions",
                          "include[]" = "observed_users",
                          "include[]" = "course_image")
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}