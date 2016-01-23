#' Get account or course analytics
#' 
#' Get a list of available reports
#' @param uri The base uri of a Canvas installation
#' @param ID The account ID to retrieve reports from
#' @param type The analytics type (e.g., activity, grades, statistics, assignments, communication, student_summaries)
#' @param term The term ID, "complete", or "current"(for account analytics only)
#' @param course Boolean to specify it the request is for a course.
#' @param studentID ID of a student for student specific requests (activity, assignment, communication)
#' @param ... Optional page options to pass to processRequest
#' @export
getAnalytics <- function(uri, ID, type = "activity", term = "current", course = FALSE, 
                         studentID = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)

        term <- paste0("terms/", term)
        
        if (course == TRUE) {
                if (!is.null(studentID)) {
                        if (!type %in% c("activity", "assignments", "communication")) {
                                stop("Student analytics available for 'activity', 'assignments', or 'commuication'")
                        } else {
                                urlbase <- sub("uri", uri, "uri/api/v1/courses/courseID/analytics/users/studentID/typeNM?")
                                urlbase <- sub("courseID", ID, urlbase)
                                urlbase <- sub("studentID", studentID, urlbase)
                                urlbase <- sub("typeNM", type, urlbase)
                                
                                urlbase <- URLencode(urlbase)
                                print(urlbase)
                        }
                } else {
                        if (!type %in% c("activity", "assignments", "student_summaries")) {
                                stop("Course analytics available for 'activity', 'assignments', or 'student_summaries'")
                        } else if (type == "communication") {
                                stop("Communciation type requires student ID.")
                        } else { 
                                urlbase <- sub("uri", uri, "uri/api/v1/courses/courseID/analytics/typeNM?")
                                urlbase <- sub("courseID", ID, urlbase)
                                urlbase <- sub("typeNM", type, urlbase)
                                
                                urlbase <- URLencode(urlbase)
                                print(urlbase)
                        }
                }
        }
        
        
        if (course == FALSE) {
                if (!type %in% c("activity", "grades", "statistics")) {
                        stop("Account analytics available for 'activity', 'grades', or 'statistics'")
                } else {
                        urlbase <- sub("uri", uri, "uri/api/v1/accounts/accountID/analytics/termID/typeNM?")
                        urlbase <- sub("accountID", ID, urlbase)
                        if (term == "terms/current" | term == "terms/completed") {
                                term <- sub("terms/", "", term)
                                urlbase <- sub("termID", term, urlbase)
                        } else {
                                urlbase <- sub("termID", term, urlbase)
                        }
                        urlbase <- sub("termID", term, urlbase)
                        
                        urlbase <- sub("typeNM", type, urlbase)
                        
                        urlbase <- URLencode(urlbase)
                        print(urlbase)                
                }
        }

        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}