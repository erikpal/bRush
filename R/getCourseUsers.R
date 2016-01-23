#' Get users from a course
#' 
#' Get user details for the provided course. Most include parameters ("email",
#' "enrollments","locked","avatar_url","bio") for this request have all been 
#' enabled and can be subsetted out if not needed.  This excludes "test_student,"
#' which has been set to its own argument.
#' @param uri The base uri of a Canvas installation
#' @param courseID Course ID to find users for
#' @param search_term Filter results by partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
#' @param user_ids Vector of user IDs to limit results by
#' @param test_student Boolean to include test student in results
#' @param type Filter results to include user with at least one of specified string ("teacher","student","ta","observer","designer")
#' @param role_id Integer of role to limit results (SIS ID not supported)
#' @param state Filter results to include only users with one of specified string ("active","invited","rejected","completed","inactive")
#' @param ... Optional page options to pass to processRequest
#' @export
getCourseUsers <- function(uri, courseID, search_term = "", user_ids = NULL,
                           test_student = FALSE, type = NULL, role_id = NULL, 
                           state = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/courses/courseID/users?")
        urlbase <- sub("courseID", courseID, urlbase)
        urlbase <- paste0(urlbase, "&include[]=email")
        urlbase <- paste0(urlbase, "&include[]=enrollments")
        urlbase <- paste0(urlbase, "&include[]=locked")
        urlbase <- paste0(urlbase, "&include[]=avatar_url")
        urlbase <- paste0(urlbase, "&include[]=bio")
        
        if (nchar(search_term) > 2) {
                urlbase <- paste0(urlbase, "&search_term=", search_term)
        }
        
        if (test_student == TRUE) {
                urlbase <- paste0(urlbase, "&include[]=test_student")
        }
        
        if (!is.null(type)) {
                urlbase <- paste0(urlbase, "&enrollment_type[]=", type)
        }
        
        if (!is.null(role_id)) {
                urlbase <- paste0(urlbase, "&enrollment_type[]=", role_id)
        }
        
        if (!is.null(user_ids)) {
                paramUserIDS <- parameterVString("user_ids", user_ids, ...)
                urlbase <- paste0(urlbase, paramUserIDS)
        }
        
        if (!is.null(state)) {
                urlbase <- paste0(urlbase, "&enrollment_state[]=", state)
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}