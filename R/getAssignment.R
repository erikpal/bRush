#' Get the a single assignment
#' 
#' @param courseID Course ID of the outcome
#' @param assignmentID Vector of user IDs of the students
#' @param include Options to include in the results
#' @param all_dates Boolean to include results hidden from learning mastery gradebook
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getAssignment <- function(courseID, assignmentID,
                              include = c("submission", "assignment_visibility", 
                                          "overrides", "observed_users", 
                                          "can_edit", "score_statistics"), 
                              all_dates = TRUE,
                              server = "test", ...){
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/COURSEID/assignments/ASSIGNMENTID"        
        url$path <- sub("COURSEID", courseID, url$path)
        url$path <- sub("ASSIGNMENTID", assignmentID, url$path)
        
        include_list <- as.list(include)
        names(include_list) <- rep("include[]", length(include_list))
        
        url$query <- c(include_list,
                       list(all_dates = TRUE))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}