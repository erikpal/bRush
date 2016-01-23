#' Get Accounts
#' 
#' Get details of accounts that you have access to. Parameters 
#' (lti_guid|registration_settings) for this request have all been enabled and 
#' can be subsetted out if not needed.
#' @param uri The base uri of a Canvas installation
#' @param ... Optional page options to pass to processRequest
#' @export
getAccounts <- function(uri, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/accounts?")
        urlbase <- paste0(urlbase, "&include[]=lti_guid")
        urlbase <- paste0(urlbase, "&include[]=registration_settings")
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)

        return(results)
}