#' Get courses from an account
#' 
#' Get course details for the provided account. All include parameters ("syllabus_body”, 
#' “term”, “course_progress”, “storage_quota_used_mb”, “total_students”, “teachers) 
#' for this request have all been enabled and can be subsetted out if not needed.
#' @param uri The base uri of a Canvas installation
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param termID Integer of enrollment term ID
#' @param search_term Filter results by partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
#' @param by_teachers Vector of user ID integers.
#' @param by_subaccounts Vector of subaccount integers.
#' @param type Filter results to include course with at least one of specified string ("teacher","student","ta","observer","designer")
#' @param ... Optional page options to pass to processRequest
#' @export
getCourses <- function(uri, accountID, termID = NULL, 
                       search_term = "", by_teachers = NULL,
                       by_subaccounts = NULL, type = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/accounts/accountID/courses?")
        urlbase <- sub("accountID", accountID, urlbase)
        urlbase <- paste0(urlbase, "&include[]=syllabus_body")
        urlbase <- paste0(urlbase, "&include[]=term")
        urlbase <- paste0(urlbase, "&include[]=course_progress")
        urlbase <- paste0(urlbase, "&include[]=storage_quota_used_mb")
        urlbase <- paste0(urlbase, "&include[]=teachers")
        urlbase <- paste0(urlbase, "&include[]=total_students")
        
        if (!is.null(termID)) {
                urlbase <- paste0(urlbase, "&enrollment_term_id=", termID)
        }
        
        if (nchar(search_term) > 2) {
                urlbase <- paste0(urlbase, "&search_term=", search_term)
        }
        
        if (!is.null(by_teachers)) {
                paramTeach <- parameterVString("by_teachers", by_teachers, ...)
                urlbase <- paste0(urlbase, paramTeach)
        }
        
        if (!is.null(by_subaccounts)) {
                paramSubacc <- parameterVString("by_subaccounts", by_subaccounts, ...)
                urlbase <- paste0(urlbase, paramSubacc)
        }
        
        if (!is.null(type)) {
                urlbase <- paste0(urlbase, "&enrollment_type[]=", type)
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)

        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}