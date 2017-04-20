#' Enroll a user in a section or course
#' 
#' Create a new section for the provided course.
#' @param url The base url of a Canvas installation.
#' @param ID Course ID for enrollment
#' @param user_id ID of the user to be enrolled
#' @param course_section_id ID of the course section to enroll student in
#' @param type Character of StudentEnrollment, TeacherEnrollment, TaEnrollment, ObserverEnrollment, DesignerEnrollment
#' @param enrollment_state Character of active, invited, inactive
#' @param limit_privileges Boolean, if true, the enrollment will only allow the user to see and interact with users enrolled in the section given by course_section_id
#' @param notify Boolean, if true, a notification will be sent to the enrolled user. 
#' @param ... Optional page options to pass to processRequest
#' @export
enrollUser <- function(url, ID, user_id, 
                       course_section_id = "",
                       type = "StudentEnrollment",
                       enrollment_state = "active",
                       limit_privileges = TRUE,
                       notify = ""){
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/ID/enrollments"
        url$path <- sub("ID", ID, url$path)
        
        ##Build the JSON for the body of the POST
        require(jsonlite)
        body <- list(
                enrollment = list(
                        user_id = user_id,        
                        course_section_id = course_section_id,
                        type = type,
                        enrollment_state = enrollment_state,
                        limit_privileges = limit_privileges,
                        notify = notify)
        )
        
        ##Convert to JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Print the url and the JSON in the console
        print(build_url(url))
        print(body)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE")
        
        return(results)
}