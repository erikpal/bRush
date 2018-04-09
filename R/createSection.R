#' Create a new section
#' 
#' Create a new section for the provided course.
#' @param courseID Course ID to create the section in.
#' @param name Character of the name of the section
#' @param sis_section_id Character of the sis id of the section
#' @param start_at Section start date in ISO8601 format, e.g. 2011-01-01T01:00Z
#' @param end_at Section end date in ISO8601 format, e.g. 2011-01-01T01:00Z
#' @param restrict Boolean, set to true to restrict user enrollments to the start and end dates of the section.
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

createSection <- function(courseID, name, 
                          sis_section_id = "",
                          start_at = "",
                          end_at = "",
                          restrict = TRUE, 
                          server = "test", ...){
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/sections"
        url$path <- sub("courseID", courseID, url$path)
        
        ##Build the JSON for the body of the POST
        require(jsonlite)
        body <- list(
                course_section = list(
                        name = name,        
                        sis_section_id = sis_section_id,
                        start_at = start_at,
                        end_at = end_at,
                        restrict_enrollments_to_section_dates = restrict)
                )
        
        ##Convert to JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}