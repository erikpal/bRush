#' Get discussions topics from a course
#' 
#' Get discussions for the provided course. Most include parameters ("email",
#' "enrollments","locked","avatar_url","bio") for this request have all been 
#' enabled and can be subsetted out if not needed.  This excludes "test_student,"
#' which has been set to its own argument.
#' @param url The base url of a Canvas installation
#' @param courseID Course ID to find assignments for
#' @param search_term Filter results by term. Must be at least 3 characters.
#' @param scope Limit results to a topic state ("locked", "unlocked", "pinned", "unpinned")
#' @param only_announcements Set to "true" for only announcements
#' @param ... Optional page options to pass to processRequest
#' @export
getDiscussionTopics <- function(url, courseID, 
                                search_term = NULL, scope = NULL, 
                                order_by = "position", 
                                only_announcements = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/discussion_topics"
        url$path <- sub("courseID", courseID, url$path)
        
        url$query <- list(search_term = search_term,
                          scope = scope,
                          order_by = order_by,
                          only_announcements = only_announcements)
        
        if (!is.null(search_term)) {
                if (nchar(search_term) < 2) {
                        warning("Search term must be three or more characters.")
                }
        }
        
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}