#' Create a new wiki page
#' 
#' Get course details for the account requesting. All include parameters (see API
#' documentation) for this request have all been enabled and can be subsetted out 
#' if not needed.
#' @param uri The base uri of a Canvas installation
#' @param ID Course or group id to create the page in
#' @param title String of page title.
#' @param body String of body content.
#' @param edit String of roles that can edit page ("teacher","student","members,"public")
#' @param notify Boolean to specify whether users should be notified of creations
#' @param publish Boolean to publish the page after creating.
#' @param front Boolean to set page as the front page
#' @param ... Optional page options to pass to processRequest
#' @export
createPage <- function(uri, ID, title = NULL, body = NULL, 
                         edit = "teachers", notify = FALSE, publish = TRUE,
                         front = FALSE) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/courses/ID/pages?")
        urlbase <- sub("ID", ID, urlbase)

        ##Build the JSON for the body of the 
        require(jsonlite)
        JSONbody <- list(
                wiki_page = list(
                        title = title,
                        body = body,
                        editing_role = edit,
                        notify_of_update = notify,
                        published = publish,
                        front_page = front
                )
        )
        JSONbody <- toJSON(JSONbody, auto_unbox = TRUE)

        urlbase <- URLencode(urlbase)
        
        print(urlbase)

        ##Pass the url to the request processor
        results <- processRequest(urlbase, JSONbody, method = "CREATE")
        
        return(results)
}