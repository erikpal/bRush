#' Get Sub-accounts
#' 
#' Get details of sub-accounts for a provided account.
#' @param uri The base uri of a Canvas installation
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param recursive Boolean to search returned subaccounts for subaccounts
#' @param ... Optional page options to pass to processRequest
#' @export
getSubaccounts <- function(uri, accountID, recursive = FALSE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        urlbase <- sub("uri", uri, "uri/api/v1/accounts/accountID/sub_accounts")
        urlbase <- sub("accountID", accountID, urlbase)
        urlbase <- paste0(urlbase, "?")
        
        if (recursive == TRUE) {
                urlbase <- paste0(urlbase, "&recursive=TRUE")
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}