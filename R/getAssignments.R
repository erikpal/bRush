#' Get assignments from a course
#' 
#' Get assignments for the provided course. Most include parameters ("email",
#' "enrollments","locked","avatar_url","bio") for this request have all been 
#' enabled and can be subsetted out if not needed.  This excludes "test_student,"
#' which has been set to its own argument.
#' @param url The base url of a Canvas installation
#' @param courseID Course ID to find assignments for
#' @param search_term Filter results by partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
#' @param bucket Limit results to a named bucket ("past", "overdue", "undated", "ungraded", "upcoming", and "future")
#' @param ... Optional page options to pass to processRequest
#' @export
getAssignments <- function(url, courseID, search_term = NULL, bucket = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/assignments"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list("include[]" = "submission",
                          "include[]" = "assignment_visibility",
                          "include[]" = "all_dates",
                          "include[]" = "overrides",
                          "include[]" = "observed_users",
                          search_term = search_term,
                          bucket = bucket)
        
        if (!is.null(search_term)) {
                if (nchar(search_term) < 2) {
                        warning("Search term must be three or more characters.")
                }
        }
        
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}