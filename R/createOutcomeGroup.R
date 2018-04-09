#' Create a new outcome group
#' 
#' Create a new outcome in an outcome group.
#' @param ID Account ID of the outcome group to create the outcome in
#' @param groupID Outcome group id to create the outcome group in
#' @param type Character of "course" or "account"
#' @param title Character of the title of the outcome group
#' @param description Character of the description of the outcome group
#' @param vendor_guid A custom GUID for the learning standard group
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
createOutcomeGroup <- function(ID, groupID,
                               type = "account", 
                               title, 
                               description = "",
                               vendor_guid = NULL, 
                               server = "test", ...){
        
        url <- loadURL(server)

        url$path <- "/api/v1/TYPE/ID/outcome_groups/groupID/subgroups"        
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
                     description = description,
                     vendor_guid = vendor_guid
        )
        
        ##Convert to JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}