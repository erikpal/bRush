#' Get details of a specific user
#' 
#' Get user details for the provided user id. 
#' @param userID User ID to find assignments for
#' @param start_time POSIXct object of date and time of due date
#' @param end_time POSIXct object of date and time of due date
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export
##TODO: This technically works but returns an error in processRequest
getUserPageViews <- function(userID, start_time = "", end_time = "", server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/users/userID/page_views"
        url$path <- sub("userID", userID, url$path)
        
        url$query <- list(start_time = start_time, 
                          end_time = end_time)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}