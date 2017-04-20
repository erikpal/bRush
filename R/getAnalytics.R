#' Get account or course analytics
#' 
#' @param url The base url of a Canvas installation
#' @param ID The account or course ID to retrieve analytics for
#' @param type The analytics type (e.g., activity, grades, statistics, assignments, communication, student_summaries)
#' @param term The term ID, "complete", or "current"(for account analytics only)
#' @param course Boolean to specify it the request is for a course.
#' @param studentID ID of a student for student specific requests (activity, assignment, communication)
#' @param ... Optional page options to pass to processRequest
#' @export
getAnalytics <- function(url, ID, type = "activity", term = "current", 
                         course = FALSE, studentID = NULL, ...) {
        require(httr)
        
        term <- paste0("terms/", term)
        url <- parse_url(url)
        
        if (course == TRUE) {
                if (!is.null(studentID)) {
                        if (!type %in% c("activity", "assignments", "communication")) {
                                stop("Student analytics available for 'activity', 'assignments', or 'commuication'")
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
        
        ##Pass the url to the request processor
        ##Adding page limitors b/c this seems to not require multiple pages to pull and creates 
        ##errors. This isn't tested on all formats, but appears to work well for course-level reports.
        results <- processRequest(url, page = 1, end_page = 1, ...)

        return(results)
}