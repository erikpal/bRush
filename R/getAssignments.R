#' Get assignments from a course
#' 
#' Get assignments for the provided course. Most include parameters ("email",
#' "enrollments","locked","avatar_url","bio") for this request have all been 
#' enabled and can be subsetted out if not needed.  This excludes "test_student,"
#' which has been set to its own argument.
#' @param uri The base uri of a Canvas installation
#' @param courseID Course ID to find assignments for
#' @param search_term Filter results by partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
#' @param bucket Limit results to a named bucket ("past", "overdue", "undated", "ungraded", "upcoming", and "future")
#' @param ... Optional page options to pass to processRequest
#' @export
getAssignments <- function(uri, courseID, search_term = "", bucket = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/courses/courseID/assignments?")
        urlbase <- sub("courseID", courseID, urlbase)
        urlbase <- paste0(urlbase, "&include[]=submission")
        urlbase <- paste0(urlbase, "&include[]=assignment_visibility")
        urlbase <- paste0(urlbase, "&include[]=all_dates")
        urlbase <- paste0(urlbase, "&include[]=overrides")
        urlbase <- paste0(urlbase, "&include[]=observed_users")
        
        if (nchar(search_term) > 2) {
                urlbase <- paste0(urlbase, "&search_term=", search_term)
        }

        if (!is.null(bucket)) {
                urlbase <- paste0(urlbase, "&bucket=", bucket)
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}