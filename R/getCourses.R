#' Get courses from an account
#' 
#' Get course details for the provided account. All include parameters ("syllabus_body”, 
#' “term”, “course_progress”, “storage_quota_used_mb”, “total_students”, “teachers) 
#' for this request have all been enabled and can be subsetted out if not needed.
#' @param url The base url of a Canvas installation
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param termID Integer of enrollment term ID
#' @param search_term Filter results by partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
#' @param by_teachers Vector of user ID integers.
#' @param by_subaccounts Vector of subaccount integers.
#' @param type Filter results to include course with at least one of specified string ("teacher","student","ta","observer","designer")
#' @param ... Optional page options to pass to processRequest
#' @export
getCourses <- function(url, accountID, termID = NULL, 
                       search_term = NULL, by_teachers = NULL,
                       by_subaccounts = NULL, type = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/accounts/accountID/courses"
        url$path <- sub("accountID", accountID, url$path)

        url$query <- list("include[]" = "syllabus_body",
                          "include[]" = "term",
                          "include[]" = "course_progress",
                          "include[]" = "storage_quota_used_mb",
                          "include[]" = "teachers",
                          "include[]" = "total_students",
                          "enrollment_type[]" = type,
                          enrollment_term_id = termID,
                          search_term = search_term)
        
        by_teachers_list <- NULL
        for (i in by_teachers) {
                by_teachers_list <- c(by_teachers_list, "by_teachers[]" = i)
        }
        
        by_subaccounts_list <- NULL
        for (i in by_subaccounts) {
                by_subaccounts_list <- c(by_subaccounts_list, "by_subaccounts[]" = i)
        }

        url$query <- c(url$query, by_teachers_list, by_subaccounts_list)
        
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}