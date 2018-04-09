#' Create a new outcome in an outcome group
#' 
#' Create a new outcome in an outcome group.
#' @param ID Account ID of the outcome group to create the outcome in
#' @param groupID Outcome group id to create the outcome in
#' @param type Character of "course" or "account"
#' @param title Character of the title of the outcome
#' @param display_name Character of a friendly name for titles that are vague/numbered.
#' @param description Character of the description of the outcome
#' @param mastery_points Integer of the mastery threshold in the rubric criterion
#' @param ratings A list of named vectors with "description" & "points" defined for each criterion
#' @param calculation_method Character of the method of calculation: decaying_average, n_mastery, latest, highest
#' @param calculation_int Integer if method is decaying_average(percent higher rate recent count as) or n_mastery (n times mastery must be acheived)
#' @param vendor_guid A custom GUID for the learning standard.
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
createOutcome <- function(ID, groupID, type = "account", title, 
                             display_name = "",
                             description = "",
                             mastery_points = NULL,
                             ratings = NULL,
                             calculation_method = "highest",
                             calculation_int = NULL,
                             vendor_guid = NULL, 
                             server = "test", ...){
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/TYPE/ID/outcome_groups/groupID/outcomes"        
        url$path <- sub("groupID", groupID, url$path)
        url$path <- sub("ID", ID, url$path)
        
        if (type == "course"){
                url$path <- sub("TYPE", "courses", url$path)
        } else if (type == "account") {
                url$path <- sub("TYPE", "accounts", url$path)
        }
        
        ##Build the JSON for the body of the POST
        require(jsonlite)
        body <- list(title = title,
                     display_name = display_name,
                     description = description,
                     mastery_points = mastery_points,
                     ratings = ratings,
                     calculation_method = calculation_method, 
                     calculation_int = calculation_int,
                     vendor_guid = vendor_guid
                     )
        
        ##Convert to JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")

        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}