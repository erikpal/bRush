#' Get Sub-accounts
#' 
#' Get details of sub-accounts for a provided account.
#' @param url The base url of a Canvas installation
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param recursive Boolean to search returned subaccounts for subaccounts
#' @param ... Optional page options to pass to processRequest
#' @export
getSubaccounts <- function(url, accountID, recursive = FALSE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        
        url$path <-  "api/v1/accounts/accountID/sub_accounts"
        url$path <- sub("accountID", accountID, url$path)

        if (recursive == TRUE) {
                url$query <- list(recursive = TRUE)
        }
        
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}