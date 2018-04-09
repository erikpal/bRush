#' Show the outcomes for the outcomes group
#' 
#' Get a list of outcomes groups in a course or account.
#' @param ID Course or account ID to retreive outcomes group from
#' @param groupID Outcome group id to get the outcome from
#' @param type Character of "course" or "account"
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getOutcomes <- function(ID, groupID, type = "account", server = "test", ...) {
        
        url <- loadURL(server)
        
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