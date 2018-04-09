#' Show the details of an outcome
#' 
#' Get a list of outcomes groups in a course or account.
#' @param ID Outcome ID
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getOutcome <- function(ID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/outcomes/ID"
        url$path <- sub("ID", ID, url$path)

        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}