#' Create a new wiki page
#' 
#' Create a new wiki page for the provided course or group.
#' @param url The base url of a Canvas installation
#' @param ID Course or group id to create the page in
#' @param title String of page title.
#' @param body String of body content.
#' @param edit String of roles that can edit page ("teacher","student","members,"public")
#' @param notify Boolean to specify whether users should be notified of creations
#' @param publish Boolean to publish the page after creating.
#' @param front Boolean to set page as the front page
#' @param ... Optional page options to pass to processRequest
#' @export
createPage <- function(url, ID, title = NULL, body = NULL, 
                        edit = "teachers", notify = FALSE,
                        publish = TRUE,
                        front = FALSE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "api/v1/courses/ID/pages"
        url$path <- sub("ID", ID, url$path)

        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list(
                wiki_page = list(
                        title = title,
                        body = body,
                        editing_role = edit,
                        notify_of_update = notify,
                        published = publish,
                        front_page = front
                )
        )
        body <- toJSON(body, auto_unbox = TRUE)

        print(build_url(url))
        print(body)

        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}