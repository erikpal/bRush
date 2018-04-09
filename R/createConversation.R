#' Create a new conversation
#' 
#' Create a single recipient conversation
#' @param userID User id of person to message
#' @param subject Character of conversation subject
#' @param body Character of body content
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

createConversation <- function(userID, subject = NULL, body = NULL, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/conversations"

        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list(
                recipients = list(userID),
                subject = subject,
                body = body)
        
        body <- toJSON(body, auto_unbox = TRUE)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}