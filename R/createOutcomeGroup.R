#' Create a new outcome group
#' 
#' Create a new outcome in an outcome group.
#' @param url The base url of a Canvas installation.
#' @param ID Account ID of the outcome group to create the outcome in
#' @param groupID Outcome group id to create the outcome group in
#' @param title Character of the title of the outcome group
#' @param description Character of the description of the outcome group
#' @param vendor_guid A custom GUID for the learning standard group
#' @param ... Optional page options to pass to processRequest
#' @export
createOutcomeGroup <- function(url, ID, groupID, title, 
                          description = "",
                          vendor_guid = NULL, ...){
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "/api/v1/accounts/ID/outcome_groups/groupID/subgroups"        
        url$path <- sub("ID", ID, url$path)        
        url$path <- sub("groupID", groupID, url$path)
        
        ##Build the JSON for the body of the POST
        require(jsonlite)
        body <- list(title = title,
                     description = description,
                     vendor_guid = vendor_guid
        )
        
        ##Convert to JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}