#' Create a new conversation
#' 
#' Create a single recipient conversation
#' @param url The base url of a Canvas installation
#' @param userID User id of person to message
#' @param subject Character of conversation subject
#' @param body Character of body content
#' @param ... Optional page options to pass to processRequest
#' @export
createConversation <- function(url, userID, subject = NULL, body = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
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