#' Show the details of an outcome
#' 
#' Get a list of outcomes groups in a course or account.
#' @param url The base url of a Canvas installation
#' @param ID Outcome ID
#' @param ... Optional page options to pass to processRequest
#' @export
getOutcome <- function(url, ID, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "/api/v1/outcomes/ID"
        url$path <- sub("ID", ID, url$path)

        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}