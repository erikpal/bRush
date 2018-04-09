#' Get discussions topic entries from a course
#' 
#' Get discussions for the provided course. Most include parameters ("email",
#' "enrollments","locked","avatar_url","bio") for this request have all been 
#' enabled and can be subsetted out if not needed.  This excludes "test_student,"
#' which has been set to its own argument.
#' @param courseID Course ID to find assignments for
#' @param topicID Topic Id to return the entries of
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getDiscussionEntries <- function(courseID, topicID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/discussion_topics/topicID/entries"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("topicID", topicID, url$path)
        
        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}