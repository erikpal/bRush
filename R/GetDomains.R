#' Get Canvas Domains
#' 
#' Gets a list of Canvas Institutions and the base URI for the Canvas.
#' @param url The base url of a Canvas installation.
#' @param name Optional string to retreive only matching results (e.g. "university")
#' @param domain Optional string to retreive only matching results (e.g. "edu")
#' @param ... Optional page options to pass to processRequest
#' @export
getDomains <- function(url, name = NULL, domain = NULL, ...) {

        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/accounts/search"
        url$query <- list(name = name, domain = domain)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)

        return(results)
}