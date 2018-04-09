#' Get Accounts
#' 
#' Get details of accounts that you have access to. Parameters 
#' (lti_guid|registration_settings) for this request have all been enabled and 
#' can be subsetted out if not needed.
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getAccounts <- function(server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/accounts"
        
        url$query <- list("include[]" = "lti_guid", "include[]" = "registration_settings")

        ##Pass the url to the request processor
        results <- processRequest(url, ...)

        return(results)
}