#' Get Users from an Account
#' 
#' Get the users from a specified account.
#' @param accountID Integer of the account ID to find users for
#' @param search_term Filter results by partial name or full ID to match and return in the results list. Must be at least 3 characters.
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getAccountUsers <- function(accountID, search_term = NULL, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/accounts/accountID/users"
        url$path <- sub("accountID", accountID, url$path)
        
        url$query <- list("include[]" = "email",
                          "include[]" = "last_login",
                          search_term = search_term)
        
        if (!is.null(search_term)) {
                if (nchar(search_term) < 2) {
                        warning("Search term must be three or more characters.")
                        }
        }
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}