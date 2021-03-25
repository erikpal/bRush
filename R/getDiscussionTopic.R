#' Get a single discussions topic from a course
#' 
#' Get discussions for the provided course. Most include parameters for this request have all been 
#' enabled and can be subsetted out if not needed.
#' @param courseID Course ID to find discussions in
#' @param topicID Topic ID to retrieve
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getDiscussionTopic <- function(courseID, 
                                topicID = NULL,
                                server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/discussion_topics/topicID"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("topicID", topicID, url$path)
        
        
        url$query <- list("include[]" = "all_dates",
                          "include[]" = "sections",
                          "include[]" = "sections_user_count",
                          "include[]" = " all_dates, sections, sections_user_count, overrides")
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}