#' Get details of a specific user
#' 
#' Get user details for the provided user id. 
#' @param uri The base uri of a Canvas installation
#' @param userID Course ID to find assignments for
#' @param ... Optional page options to pass to processRequest
#' @export
##TODO: This technically works but returns an error in processRequest
getUser <- function(uri, userID, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/users/userID?")
        urlbase <- sub("userID", userID, urlbase)

        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
        return(results)
}