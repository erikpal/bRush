#' Edit a discussion topic
#' 
#' Edit an exisitng discusson for the provided course or group.
#' @param courseID Course or group ID to create the discussion in.
#' @param topicID ID for the discussion topic
#' @param title Character of the title of the assignment
#' @param message Character of the discussion message.
#' @param discussion_type Character of the discussion type ("side_comment" or "threaded")
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
#' @param points_possible Integer of the maximum number of points possible
#' @param peer_reviews Boolean to enable peer reviews
#' @param automatic_peer_reviews Boolean to enable automatically assign peer reviewers
#' @param grading_type Character of grading type options (pass_fail, percent, letter_grade, gpa_scale, points)
#' @param grading_standard_id ID of the grading standard to be used
#' @param due_at POSIXct object of date and time of due date if an assignment
#' @param lock_at POSIXct object of date and time of lock date if an assignment
#' @param unlock_at POSIXct object of date and time of unlock date if an assignment
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest if an assignment
#' @export

editDiscussionTopic <- function(courseID, 
                                  topicID,
                                  title = NULL, 
                                  message = NULL,
                                  discussion_type = NULL,
                                  published = NULL,
                                  podcast_enabled = NULL,
                                  podcast_has_student_posts = NULL,
                                  require_initial_post = NULL,
                                  is_announcement = NULL,
                                  pinned = NULL,
                                  allow_rating = NULL,
                                  only_graders_can_rate = NULL,
                                  sort_by_rating = NULL,
                                  delayed_post_at = NULL,
                                  lock_at = NULL,
                                  position_after = NULL,
                                  group_category_id = NULL,
                                  points_possible = NULL,
                                  peer_reviews = NULL,
                                  automatic_peer_reviews = NULL,
                                  grading_type = NULL,
                                  grading_standard_id = NULL,
                                  due_at = NULL,
                                  unlock_at = NULL, 
                                  server = "test", ...){
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/discussion_topics/topicID"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("topicID", topicID, url$path)
        
        
        ## Build the JSON for the body of the POST
        ##Build JSON for any element provided
        require(jsonlite)
        body <- NULL
        if(!is.null(title)){body$title = title}
        if(!is.null(message)){body$message = message}
        if(!is.null(discussion_type)){body$discussion_type = discussion_type}
        if(!is.null(published)){body$published = published}
        if(!is.null(podcast_enabled)){body$podcast_enabled = podcast_enabled}
        if(!is.null(podcast_has_student_posts)){body$podcast_has_student_posts = podcast_has_student_posts}
        if(!is.null(require_initial_post)){body$require_initial_post = require_initial_post}
        if(!is.null(is_announcement)){body$is_announcement = is_announcement}
        if(!is.null(pinned)){body$pinned = pinned}
        if(!is.null(allow_rating)){body$allow_rating = allow_rating}
        if(!is.null(only_graders_can_rate)){body$only_graders_can_rate = only_graders_can_rate}
        if(!is.null(delayed_post_at)){body$delayed_post_at = delayed_post_at}
        if(!is.null(lock_at)){body$lock_at = lock_at}

        ## Some parameters cause errors as NULL or empty quotes this excludes if NULL
        if(!is.null(position_after)){body$position_after = as.character(position_after)}
        if(!is.null(group_category_id)){body$group_category_id = as.character(group_category_id)}
        
        ## Uses points_possible as an indication that this is an assignment 
        body$assignment <- NULL
        if(!is.null(points_possible)){body$assignment$points_possible = as.character(points_possible)}
        if(!is.null(peer_reviews)){body$assignment$peer_reviews = peer_reviews}
        if(!is.null(automatic_peer_reviews)){body$assignment$automatic_peer_reviews = automatic_peer_reviews}
        if(!is.null(grading_type)){body$assignment$grading_type = grading_type}
        if(!is.null(due_at)){body$assignment$due_at = due_at}
        if(!is.null(unlock_at)){body$assignment$unlock_at = unlock_at}
        if(!is.null(grading_standard_id)){body$assignment$grading_standard_id = as.character(grading_standard_id)}
        
        ## Convert to JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ## Pass the url to the request processor
        results <- processRequest(url, body, method = "EDIT", ...)
        
        return(results)
}