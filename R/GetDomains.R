#' Get Canvas Domains
#' 
#' Gets a list of Canvas Institutions and the base URI for the Canvas.
#' @param uri The base uri of a Canvas installation.
#' @param name Optional string to retreive only matching results (e.g. "university")
#' @param domain Optional string to retreive only matching results (e.g. "edu")
#' @param ... Optional page options to pass to processRequest
#' @export
getDomains <- function(uri, name = "", domain = "", ...) {

        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/accounts/search?")
        urlbase <- paste0(urlbase, "&name=", name)
        urlbase <- paste0(urlbase, "&domain=", domain)
        
        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)

        return(results)
}