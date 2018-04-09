#' Get users from a course
#' 
#' Get user details for the provided course. Most include parameters ("email",
#' "enrollments","locked","avatar_url","bio") for this request have all been 
#' enabled and can be subsetted out if not needed.  This excludes "test_student,"
#' which has been set to its own argument.
#' @param courseID Course ID to find users for
#' @param search_term Filter results by partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
#' @param user_ids Vector of user IDs to limit results by
#' @param test_student Boolean to include test student in results
#' @param type Filter results to include user with at least one of specified string ("teacher","student","ta","observer","designer")
#' @param role_id Integer of role to limit results (SIS ID not supported)
#' @param state Filter results to include only users with one of specified string ("active","invited","rejected","completed","inactive")
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getCourseUsers <- function(courseID, search_term = NULL, user_ids = NULL,
                           test_student = FALSE, type = NULL, role_id = NULL, 
                           state = NULL, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/users"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list("include[]" = "email",
                          "include[]" = "enrollments",
                          "include[]" = "locked",
                          "include[]" = "avatar_url",
                          "include[]" = "bio",
                          search_term = search_term,
                          "enrollment_type[]" = type,
                          "enrollment_type[]" = role_id,
                          "enrollment_state[]" = state)
        
        if (test_student == TRUE) {
                url$query <- c(url$query, "include[]" = "test_student")
        }
        
        user_ids_list <- NULL
        for (i in user_ids) {
                user_ids_list <- c(user_ids_list, "user_ids[]" = i)
        }
        url$query <- c(url$query, user_ids_list)
        
        if (!is.null(search_term)) {
                if (nchar(search_term) < 2) {
                        warning("Search term must be three or more characters.")
                }
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}