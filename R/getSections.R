#' Get sections from a course
#' 
#' Get sections for the provided course. All includes enabled: students, avatar_url, enrollments,
#' total_students, and passback_status.
#' @param courseID Course ID to find assignments for
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getSections <- function(courseID, server = "test", ...) {
        
        url <- loadURL(server)
        
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