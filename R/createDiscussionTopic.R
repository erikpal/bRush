#' Create a new discussion
#' 
#' Create a new discusson for the provided course or group.
#' @param url The base url of a Canvas installation.
#' @param ID Course or group ID to create the discussion in.
#' @param title Character of the title of the assignment
#' @param message Character of the discussion message.
#' @param discussion_type Character of the discussion type (“side_comment” or "threaded)
#' @param published Boolean to specify if the discussion is published for availability.
#' @param podcast_enabled Boolean to enable podcast feed.
#' @param podcast_has_student_posts Boolean to include student replies in podcast feed.
#' @param require_initial_post Boolean to specify if user must post first to begin to reply.
#' @param is_announcement Boolean to specify if this is an announcment instead of a discussion.
#' @param pinned Boolean to list as a pinned discussion.
#' @param allow_rating Boolean to allow users to rate entries.
#' @param only_graders_can_rate Boolean to allow only graders to rate.
#' @param sort_by_rating Boolean to sort by rating.
#' @param delayed_post_at POSIXct object of date and time to publish discussion.
#' @param lock_at POSIXct object of date and time to lock for further posts.
#' @param position_after ID of discussion topic to position this one after.
#' @param group_category_id ID of group to assign discussion to.
#' @param assignment Boolean to make this a graded assignment.
#' @param points_possible Integer of the maximum number of points possible
#' @param peer_reviews Boolean to enable peer reviews
#' @param automatic_peer_reviews Boolean to enable automatically assign peer reviewers
#' @param grading_type Character of grading type options (pass_fail, percent, letter_grade, gpa_scale, points)
#' @param grading_standard_id ID of the grading standard to be used
#' @param due_at POSIXct object of date and time of due date if an assignment
#' @param lock_at POSIXct object of date and time of lock date if an assignment
#' @param unlock_at POSIXct object of date and time of unlock date if an assignment
#' @param ... Optional page options to pass to processRequest if an assignment
#' @export

createDiscussionTopic <- function(url, ID, title, message = "",
                                  discussion_type = "side_comment",
                                  published = FALSE,
                                  podcast_enabled = FALSE,
                                  podcast_has_student_posts = FALSE,
                                  require_initial_post = FALSE,
                                  is_announcement = FALSE,
                                  pinned = FALSE,
                                  allow_rating = FALSE,
                                  only_graders_can_rate = FALSE,
                                  sort_by_rating = FALSE,
                                  delayed_post_at = "",
                                  lock_at = "",
                                  position_after = NULL,
                                  group_category_id = NULL,
                                  points_possible = NULL,
                                  peer_reviews = FALSE,
                                  automatic_peer_reviews = FALSE,
                                  grading_type = "points",
                                  grading_standard_id = NULL,
                                  due_at = "",
                                  unlock_at = "", ...){
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/ID/discussion_topics"
        url$path <- sub("ID", ID, url$path)
        
        ##Build the JSON for the body of the POST
        require(jsonlite)
        body <- list(title = title, 
                     message = message,
                     discussion_type = discussion_type,
                     published = published,
                     podcast_enabled = podcast_enabled,
                     podcast_has_student_posts = podcast_has_student_posts,
                     require_initial_post = require_initial_post,
                     is_announcement = is_announcement,
                     pinned = pinned,
                     allow_rating = allow_rating,
                     only_graders_can_rate = only_graders_can_rate,
                     sort_by_rating = sort_by_rating,
                     delayed_post_at = delayed_post_at,
                     lock_at = lock_at)
        
        ##Some parameters cause errors as NULL or ""; this excludes if NULL
        if(!is.null(position_after)){body$position_after = as.character(position_after)}
        if(!is.null(group_category_id)){body$group_category_id = as.character(group_category_id)}
        
        ##Uses points_possible as an indication that this is an assignment 
        if (!is.null(points_possible)) {
                assignment = list(
                        points_possible = as.character(points_possible),
                        peer_reviews = peer_reviews,
                        automatic_peer_reviews = automatic_peer_reviews,
                        grading_type = grading_type,
                        due_at = due_at,
                        unlock_at = unlock_at
                )
                body$assignment <- assignment
        }
        ##Some parameters cause errors as NULL or ""; this excludes if NULL
        if(!is.null(grading_standard_id)){body$assignment$grading_standard_id = as.character(grading_standard_id)}
        
        ##Convet to JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}