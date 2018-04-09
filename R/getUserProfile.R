#' Get profile of a specific user
#' 
#' Get user details for the provided user id. NOTE: Returns as a list.
#' @param userID User ID to profile of
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getUserProfile <- function(userID, server = "test", ...) {
        
        url <- loadURL(server)

        url$path <- "api/v1/users/userID/profile"
        url$path <- sub("userID", userID, url$path)
        
        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}