#' Edit an assignment
#' 
#' Edit an assignment of the provided ID for the provided course.
#' @param url The base url of a Canvas installation.
#' @param courseID Course ID to create the assignment in.
#' @param assignID Assignment ID of the assignment to edit.
#' @param name Character of the name of the assignment
#' @param description Character description of the assignments, supports HTML.
#' @param points_possible Integer of the maximum number of points possible
#' @param published Boolean to specify if the assignment is published for availability.
#' @param type One character of assignment type ("online","none", "on_paper", "online_quiz", "discussion_topic", "external_tool") 
#' @param online_type If type is "online", vector of online types ("online_upload", "online_text_entry", "online_url", "media_recording")
#' @param allowed_extensions Character of the extensions allowed for file submissions for "online_upload"
#' @param turnitin_enabled Boolean to specify whether to use the Turnitin API.
#' @param turnitin_settings Named list of turnitin settings.
#' @param peer_reviews Boolean to enable peer reviews
#' @param automatic_peer_reviews Boolean to enable automatically assign peer reviewers
#' @param notify_of_update Boolean to notify students that assignment content has changed.
#' @param external_tool_tag_attributes Named list od external tool attributes.
#' @param grading_type Character of grading type options (pass_fail, percent, letter_grade, gpa_scale, points)
#' @param group_category_id ID of group to assign discussion to.
#' @param due_at POSIXct object of date and time of due date
#' @param lock_at POSIXct object of date and time of lock date
#' @param unlock_at POSIXct object of date and time of unlock date
#' @param assignment_group_id Integer of the assignment group to put assignment in.
#' @param muted Boolean to mute assignment or not
#' @param grade_group_students_individually Boolean to say group students will be graded individually.
#' @param grading_standard_id Integer id of the grading standard used.
#' @param ext_tool_url Character of external tool url if type is "external_tool".
#' @param ext_tool_new_tab Boolean of whether ext tool opens in new tab.
#' @param ... Optional page options to pass to processRequest
#' @export
editAssignment <- function(url, courseID, assignID, name = NULL, description = NULL,
                           points_possible = NULL,
                           type = NULL,
                           online_type = NULL,
                           allowed_extensions = NULL,
                           grading_type = NULL,
                           assignment_group_id = NULL,
                           grading_standard_id = NULL,
                           group_category_id = NULL,
                           due_at = NULL,
                           lock_at = NULL,
                           unlock_at = NULL,
                           published = NULL,
                           turnitin_enabled = NULL,
                           peer_reviews = NULL,
                           automatic_peer_reviews = NULL,
                           notify_of_update = NULL,
                           muted = NULL,
                           grade_group_students_individual = NULL,
                           ext_tool_url = NULL,
                           ext_tool_new_tab = NULL){
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/courseID/assignments/assignID"
        url$path <- sub("courseID", courseID, url$path)
        url$path <- sub("assignID", assignID, url$path)
        
        ##Set a default if nothing provided
        if (!is.null(online_type) & is.null(type)) {type <- "online"}
        
        ##Warn that online submissions need a type
        if (!is.null(type)) {
                if (type == "online") {
                        if (is.null(online_type)) {stop("Must provide online submission types as online_type")}
                        type <- online_type
                }
        }
        
        ##Build JSON for any element provided
        require(jsonlite)
        body <- NULL
        body$assignment <- NULL
                if(!is.null(name)){body$assignment$name = name}
                if(!is.null(description)){body$assignment$description = description}
                if(!is.null(points_possible)){body$assignment$points_possible = points_possible}
                if(!is.null(type)){body$assignment$submission_types = type}
                if(!is.null(allowed_extensions)){body$assignment$allowed_extensions = allowed_extensions}
                if(!is.null(grading_type)){body$assignment$grading_type = grading_type}
                if(!is.null(assignment_group_id)){body$assignment$assignment_group_id = assignment_group_id}
                if(!is.null(grading_standard_id)){body$assignment$grading_standard_id = grading_standard_id}
                if(!is.null(group_category_id)){body$assignment$group_category_id = group_category_id}
                if(!is.null(due_at)){body$assignment$description = due_at}
                if(!is.null(lock_at)){body$assignment$lock_at = lock_at}
                if(!is.null(unlock_at)){body$assignment$unlock_at = unlock_at}
                if(!is.null(published)){body$assignment$published = published}
                if(!is.null(turnitin_enabled)){body$assignment$turnitin_enabled = turnitin_enabled}
                if(!is.null(peer_reviews)){body$assignment$peer_reviews = peer_reviews}
                if(!is.null(notify_of_update)){body$assignment$notify_of_update = notify_of_update}
                if(!is.null(muted)){body$assignment$muted = muted}
                if(!is.null(grade_group_students_individual)){body$assignment$grade_group_students_individual = grade_group_students_individual}
        
        ##If an external_tool type is specified, pass the ext tool parameters
        ##if provided
        if (!is.null(type)) {
                if (type[1] == "external_tool") {
                        external_tool_tag_attributes <- NULL
                        if(!is.null(ext_tool_url)){external_tool_tag_attributes$url = ext_tool_url}
                        if(!is.null(ext_tool_new_tab)){external_tool_tag_attributes$new_tab = ext_tool_new_tab}
                        body[[1]]$external_tool_tag_attributes <- external_tool_tag_attributes
                }
        }
        
        ##Make the JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Print the url and the JSON in the console
        print(build_url(url))
        print(body)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "EDIT")
        
        return(results)
}