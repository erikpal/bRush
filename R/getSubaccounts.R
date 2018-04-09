#' Get Sub-accounts
#' 
#' Get details of sub-accounts for a provided account.
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param recursive Boolean to search returned subaccounts for subaccounts
#' @param server The base url of a Canvas installation
#' @param ... Optional page options to pass to processRequest
#' @export
getSubaccounts <- function(accountID, recursive = FALSE, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <-  "api/v1/accounts/accountID/sub_accounts"
        url$path <- sub("accountID", accountID, url$path)

        if (recursive == TRUE) {
                url$query <- list(recursive = TRUE)
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}