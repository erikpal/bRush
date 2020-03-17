#' Create a content migration.
#' 
#' Create a content migration with migrator type and a settings list. Does not
#' currently support file uploads.  Limited testing conducted on various migrators.
#' @param accountID Account ID of context to import into.
#' @param userID User ID of individual to make admin.
#' @param roleID ID number of the role.
#' @param send_confirmation Boolean to send notification
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export
createAdmin <- function(accountID, userID, roleID, 
                            send_confirmation = FALSE, 
                            server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/accounts/accountID/admins"

        url$path <- sub("accountID", accountID, url$path)
        
        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list(
                user_id = userID,
                role_id = roleID,
                send_confirmation = send_confirmation
        )
        
        ##Convert ot JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}