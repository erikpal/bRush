#' Show the outcomes for the outcomes group
#' 
#' Get a list of outcomes groups in a course or account.
#' @param url The base url of a Canvas installation
#' @param ID Course or account ID to retreive outcomes group from
#' @param groupID Outcome group id to create the outcome in
#' @param type Character of "course" or "account"
#' @param ... Optional page options to pass to processRequest
#' @export
getLinkedOutcomes <- function(url, ID, groupID, type = "account", ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "/api/v1/TYPE/ID/outcome_groups/groupID/outcomes"
        url$path <- sub("ID", ID, url$path)
        url$path <- sub("groupID", groupID, url$path)
        
        if (type == "course"){
                url$path <- sub("TYPE", "courses", url$path)
        } else if (type == "account") {
                url$path <- sub("TYPE", "accounts", url$path)
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}