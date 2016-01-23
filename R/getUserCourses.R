#' Get courses for a user
#' 
#' Get course details for the account requesting. All include parameters (see API
#' documentation) for this request have all been enabled and can be subsetted out 
#' if not needed.
#' @param uri The base uri of a Canvas installation
#' @param userID The string of a user to request courses of
#' @param state String of enrollment state to limit results to (“unpublished”,“available”,“completed”,“deleted”)
#' @param ... Optional page options to pass to processRequest
#' @export
getUserCourses <- function(uri, userID, type = NULL, enrollment_role_id = NULL, 
                         state = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/users/userID/courses?")
        urlbase <- sub("userID", userID, urlbase)
        urlbase <- paste0(urlbase, "&include[]=needs_grading_count")
        urlbase <- paste0(urlbase, "&include[]=syllabus_body")
        urlbase <- paste0(urlbase, "&include[]=term")
        urlbase <- paste0(urlbase, "&include[]=course_progress")
        urlbase <- paste0(urlbase, "&include[]=sections")
        urlbase <- paste0(urlbase, "&include[]=storage_quota_used_mb")
        urlbase <- paste0(urlbase, "&include[]=total_students")
        urlbase <- paste0(urlbase, "&include[]=favorites")
        urlbase <- paste0(urlbase, "&include[]=total_scores")
        
        if (!is.null(state)) {
                urlbase <- paste0(urlbase, "&state[]=", state)
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}