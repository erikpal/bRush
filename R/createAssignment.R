#' Create a new assignment
#' 
#' Create a new assignment for the provided course.
#' @param url The base url of a Canvas installation.
#' @param ID Course ID to create the assignment in.
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
#' @param grading_standard_id ID of the grading standard to be used
#' @param muted Boolean to mute assignment or not
#' @param grade_group_students_individually Boolean to say group students will be graded individually.
#' @param ext_tool_url Character of external tool url if type is "external_tool".
#' @param ext_tool_new_tab Boolean of whether ext tool opens in new tab.
#' @param ... Optional page options to pass to processRequest
#' @export
createAssignment <- function(url, ID, name, description = "",
                             points_possible = "",
                             type =  "online",
                             online_type = c("online_upload", "online_text_entry"),
                             allowed_extensions = c("doc","docx","pdf","ppt","pptx","rtf"),
                             grading_type = "points",
                             assignment_group_id = "",
                             grading_standard_id = "",
                             group_category_id = "",
                             due_at = "",
                             lock_at = "",
                             unlock_at = "",
                             published = FALSE,
                             turnitin_enabled = FALSE,
                             peer_reviews = FALSE,
                             automatic_peer_reviews = FALSE,
                             notify_of_update = FALSE,
                             muted = FALSE,
                             grade_group_students_individual = FALSE,
                             ext_tool_url = NULL,
                             ext_tool_new_tab = FALSE){

        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/ID/assignments"
        url$path <- sub("ID", ID, url$path)
        
        ##Set type to the online type options provided
        ##This is b/c online online types can have multiple item
        if (type == "online") {
                type <- online_type
        }
        
        ##Build the JSON for the body of the POST
        require(jsonlite)
        body <- list(
                assignment = list(
                        name = name,
                        description = description,
                        points_possible = as.character(points_possible),
                        submission_types = type,
                        allowed_extensions = allowed_extensions,
                        grading_type = grading_type,
                        assignment_group_id = assignment_group_id,
                        grading_standard_id = grading_standard_id,
                        group_category_id = group_category_id,
                        due_at = due_at,
                        lock_at = lock_at,
                        unlock_at = unlock_at,
                        published = published,
                        turnitin_enabled = turnitin_enabled,
                        peer_reviews = peer_reviews,
                        automatic_peer_reviews = automatic_peer_reviews,
                        notify_of_update = notify_of_update,
                        muted = muted,
                        grade_group_students_individual = grade_group_students_individual)
                )
        
        ##If an external tool type is specified build the additional parameters
        if (type[1] == "external_tool") {
                external_tool_tag_attributes = list(
                        url = ext_tool_url,
                        new_tab = ext_tool_new_tab
                )
                body[[1]]$external_tool_tag_attributes <- external_tool_tag_attributes
        }
        
        ##Convert ot JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Print the url and the JSON in the console
        print(build_url(url))
        print(body)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE")
        
        return(results)
}