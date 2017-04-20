#' Get details of a specific user
#' 
#' Get user details for the provided user id. 
#' @param url The base url of a Canvas installation
#' @param userID User ID to find assignments for
#' @param ... Optional page options to pass to processRequest
#' @export
##TODO: This technically works but returns an error in processRequest
getUser <- function(url, userID, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "api/v1/users/userID"
        url$path <- sub("userID", userID, url$path)

        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}