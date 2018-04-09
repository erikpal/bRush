#' Get all outcome links for a context
#' 
#' Get a list of outcomes in a course or account.
#' @param ID Course or account ID to retreive outcomes groups from
#' @param type Character of "course" or "account"
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getOutcomeLinks <- function(ID, type = "account", server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/TYPE/ID/outcome_group_links"
        url$path <- sub("ID", ID, url$path)
        
        if (type == "course"){
                url$path <- sub("TYPE", "courses", url$path)
        } else if (type == "account") {
                url$path <- sub("TYPE", "accounts", url$path)
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}