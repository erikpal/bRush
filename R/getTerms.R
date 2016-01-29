#' Get Terms
#' 
#' Get terms in a specified account.
#' @param url The base url of a Canvas installation
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param state Optional string "active" or "deleted" to limit request
#' @param ... Optional page options to pass to processRequest
#' @export

##I can't test this one since I don't have manage privileges for the root account.
##Applied to a subaccount, it redirects to the root and returns an error.
##The error is not JSON data so it doesn't work, further testing with access needed

getTerms <- function(url, accountID, state = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        
        require(httr)
        url <- parse_url(url)
        
        url$path <-  "api/v1/accounts/accountID/terms"
        url$path <- sub("accountID", accountID, url$path)
        url$query <- list(workflow_state = state)
        
        print(build_url(url))
        
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}