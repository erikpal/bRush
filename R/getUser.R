#' Get details of a specific user
#' 
#' Get user details for the provided user id. NOTE: Returns a list.
#' @param userID User ID to get details for
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getUser <- function(userID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/users/userID"
        url$path <- sub("userID", userID, url$path)

        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}