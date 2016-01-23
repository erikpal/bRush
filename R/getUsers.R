#' Get Users from an Account
#' 
#' Get the users from a specified account.
#' @param uri The base uri of a Canvas installation
#' @param accountID Integer of the account ID to find sub-accounts for
#' @param search_term Filter results by partial name or full ID to match and return in the results list. Must be at least 3 characters.
#' @param ... Optional page options to pass to processRequest
#' @export
getUsers <- function(uri, accountID, search_term = "", ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/accounts/accountID/users?")
        urlbase <- sub("accountID", accountID, urlbase)
        urlbase <- paste0(urlbase, "&include[]=email")
        urlbase <- paste0(urlbase, "&include[]=last_login")
        
        if (nchar(search_term) > 2) {
                urlbase <- paste0(urlbase, "&search_term=", search_term)
        }
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}