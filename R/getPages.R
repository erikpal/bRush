#' Get pages of a course
#' 
#' Get a list of pages in course or group.
#' @param url The base url of a Canvas installation
#' @param ID Course or group ID to retreiv pages of
#' @param sort Character of how to sort list ("title","created_at","updated_at")
#' @param order Character of order to sort ("asc","desc")
#' @param search_term Filter results by partial title. Must be at least 3 characters.
#' @param published Boolean to include only published pages
#' @param ... Optional page options to pass to processRequest
#' @export
getPages <- function(url, ID, sort = NULL, order = NULL, 
                                 search_term = NULL, published = NULL, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        url$path <- "api/v1/courses/ID/pages"
        url$path <- sub("ID", ID, url$path)

        url$query <- list(sort = sort,
                          order = order,
                          search_term = search_term,
                          published = published)
                          
        print(build_url(url))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}