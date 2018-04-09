#' Get Canvas Domains
#' 
#' Gets a list of Canvas Institutions and the base URI for the Canvas.
#' @param name Optional string to retreive only matching results (e.g. "university")
#' @param domain Optional string to retreive only matching results (e.g. "edu")
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getDomains <- function(name = NULL, domain = NULL, server = "test", ...) {

        url <- loadURL(server)
        
        url$path <- "api/v1/accounts/search"
        url$query <- list(name = name, domain = domain)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)

        return(results)
}