#' Get Users from an Account
#' 
#' Get the users from a specified account.
#' @param url The base url of a Canvas installation
#' @param accountID Integer of the account ID to find users for
#' @param search_term Filter results by partial name or full ID to match and return in the results list. Must be at least 3 characters.
#' @param ... Optional page options to pass to processRequest
#' @export
getAccountUsers <- function(url, accountID, search_term = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
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