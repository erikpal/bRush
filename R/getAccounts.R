#' Get Accounts
#' 
#' Get details of accounts that you have access to. Parameters 
#' (lti_guid|registration_settings) for this request have all been enabled and 
#' can be subsetted out if not needed.
#' @param url The base url of a Canvas installation
#' @param ... Optional page options to pass to processRequest
#' @export
getAccounts <- function(url, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/accounts"
        
        url$query <- list("include[]" = "lti_guid", "include[]" = "registration_settings")
        
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)

        return(results)
}