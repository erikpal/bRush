#' Get a list of admins for an account
#' 
#' Get a list of roles for an account
#' @param accountID Account ID to retereive admins of
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getAdmins <- function(accountID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/accounts/accountID/admins"
        url$path <- sub("accountID", accountID, url$path)
        
        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}