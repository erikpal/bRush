#' Get Terms
#' 
#' Get terms in the specified account.
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param state Optional string "active" or "deleted" to limit request
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
#' 
getTerms <- function(accountID, state = NULL, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <-  "api/v1/accounts/accountID/terms"
        url$path <- sub("accountID", accountID, url$path)
        url$query <- list(workflow_state = state)
        
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}