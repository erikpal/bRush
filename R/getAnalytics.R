#' Get account or course analytics
#' 
#' @param type The analytics type (e.g., activity, grades, statistics, assignments, communication, student_summaries)
#' @param term The term ID, "complete", or "current"(for account analytics only)
#' @param course Boolean to specify it the request is for a course.
#' @param studentID ID of a student for student specific requests (activity, assignment, communication)
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

##TODO: Needs to be updated to match changes to the API, which are more organized.
##https://canvas.instructure.com/doc/api/analytics.html

getAnalytics <- function(ID, type = "activity", term = "current", 
                         course = FALSE, studentID = NULL, 
                         server = "test", ...) {

        url <- loadURL(server)
        
        term <- paste0("terms/", term)
        
        if (course == TRUE) {
                if (!is.null(studentID)) {
                        if (!type %in% c("activity", "assignments", "communication")) {
                                stop("Student analytics available for 'activity', 'assignments', or 'communication'")
                        } else {
                                url$path <- "api/v1/courses/courseID/analytics/users/studentID/typeNM"
                                url$path <- sub("courseID", ID, url$path)
                                url$path <- sub("studentID", studentID, url$path)
                                url$path <- sub("typeNM", type, url$path)
                        }
                } else {
                        if (!type %in% c("activity", "assignments", "student_summaries")) {
                                stop("Course analytics available for 'activity', 'assignments', or 'student_summaries'")
                        } else if (type == "communication") {
                                stop("Communciation type requires student ID.")
                        } else { 
                                url$path <- "api/v1/courses/courseID/analytics/typeNM"
                                url$path <- sub("courseID", ID, url$path)
                                url$path <- sub("typeNM", type, url$path)
                        }
                }
        }
        
        
        if (course == FALSE) {
                if (!type %in% c("activity", "grades", "statistics")) {
                        stop("Account analytics available for 'activity', 'grades', or 'statistics'")
                } else {
                        url$path <- "/api/v1/accounts/accountID/analytics/termID/typeNM"
                        url$path <- sub("accountID", ID, url$path)
                        if (term == "terms/current" | term == "terms/completed") {
                                term <- sub("terms/", "", term)
                                url$path <- sub("termID", term, url$path)
                        } else {
                                url$path <- sub("termID", term, url$path)
                        }
                        url$path <- sub("termID", term, url$path)
                        url$path <- sub("typeNM", type, url$path)
                }
        }

        url$query <- list(exclude = NULL)
        
        results <- processRequest(url, ...)

        return(results)
}