#' Get discussions topic entries from a course
#' 
#' Get discussions for the provided course. Most include parameters ("email",
#' "enrollments","locked","avatar_url","bio") for this request have all been 
#' enabled and can be subsetted out if not needed.  This excludes "test_student,"
#' which has been set to its own argument.
#' @param url The base url of a Canvas installation
#' @param courseID Course ID to find assignments for
#' @param topicID Topic Id to return the entries of
#' @param ... Optional page options to pass to processRequest
#' @export
getDiscussionEntries <- function(url, courseID, topicID, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/discussion_topics/topicID/entries"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("topicID", topicID, url$path)
        
        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}