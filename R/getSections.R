#' Get sections from a course
#' 
#' Get sections for the provided course. All includes enabled: students, avatar_url, enrollments,
#' total_students, and passback_status.
#' @param url The base url of a Canvas installation
#' @param courseID Course ID to find assignments for
#' @param ... Optional page options to pass to processRequest
#' @export
getSections <- function(url, courseID, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/sections"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list("include[]" = "students",
                          "include[]" = "avatar_url",
                          "include[]" = "enrollments",
                          "include[]" = "total_students",
                          "include[]" = "passback_status")
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}