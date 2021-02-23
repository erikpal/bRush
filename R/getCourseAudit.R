#' Get a course audit object
#' 
#' Get a list of pages in course or group.
#' @param courseID Course or group ID of page
#' @param start_time Start date and in ISO8601 format, e.g. 2011-01-01T01:00Z
#' @param end_time End date and in ISO8601 format, e.g. 2011-01-01T01:00Z
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getCourseAudit <- function(courseID, start_time = NULL, 
                    end_time = NULL, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/audit/course/courses/courseID"
        url$path <- sub("courseID", courseID, url$path)

        url$query <- list(start_time = start_time,
                          end_time = end_time)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}