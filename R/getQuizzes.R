#' Get quizzes from a course
#' 
#' Get quizzes for the provided course.
#' @param url The base url of a Canvas installation
#' @param courseID Course ID to find quizzes for
#' @param search_term Filter results by partial course name, code, or full ID to match and return in the results list. Must be at least 3 characters.
#' @export
getQuizzes <- function(url, courseID, search_term = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/quizzes"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list(search_term = search_term)
        
        if (!is.null(search_term)) {
                if (nchar(search_term) < 2) {
                        warning("Search term must be three or more characters.")
                }
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}