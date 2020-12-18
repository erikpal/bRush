#' Get a list of rubrics from an account or course
#' 
#' @param ID Integer of the account ID to find users for
#' @param type Course or account
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getRubrics <- function(ID, type = "account", server = "test", ...) {
        
        url <- loadURL(server)
        
        if (type == "account") {
                url$path <- "api/v1/accounts/ID/rubrics"
                url$path <- sub("ID", ID, url$path)
        }
        
        if (type == "course") {
                url$path <- "api/v1/courses/ID/rubrics"
                url$path <- sub("ID", ID, url$path)
        }
        
        if (!type %in% c("course", "account")) {
                warning('Type must be for "course" or "account" only.')
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}