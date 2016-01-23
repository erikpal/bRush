#' Get Terms
#' 
#' Get terms in a specified account.
#' @param uri The base uri of a Canvas installation
#' #' @param accountID Integer of the account ID to find sub-accounts for
#' @param state Optional string "active" or "deleted" to limit request
#' @param ... Optional page options to pass to processRequest
#' @export

##I can't test this one since I don't have manage privileges for the root account.
##Applied to a subaccount, it redirects to the root and returns an error.
##The error is not JSON data so it doesn't work, further testing with access needed

getTerms <- function(uri, accountID, state = "", ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        urlbase <- sub("uri", uri, "uri/api/v1/accounts/accountID/terms")
        urlbase <- sub("accountID", accountID, urlbase)
        urlbase <- paste0(urlbase, "?workflow_state=", state)
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}