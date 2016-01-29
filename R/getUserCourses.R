#' Get courses for a user
#' 
#' Get course details for the account requesting. All include parameters (see API
#' documentation) for this request have all been enabled and can be subsetted out 
#' if not needed.
#' @param url The base url of a Canvas installation
#' @param userID The string of a user to request courses of
#' @param state String of enrollment state to limit results to (“unpublished”,“available”,“completed”,“deleted”)
#' @param ... Optional page options to pass to processRequest
#' @export
getUserCourses <- function(url, userID, state = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
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
        
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}