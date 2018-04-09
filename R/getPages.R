#' Get pages of a course
#' 
#' Get a list of pages in course or group.
#' @param ID Course or group ID to retreiv pages of
#' @param sort Character of how to sort list ("title","created_at","updated_at")
#' @param order Character of order to sort ("asc","desc")
#' @param search_term Filter results by partial title. Must be at least 3 characters.
#' @param published Boolean to include only published pages
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getPages <- function(ID, sort = NULL, order = NULL, 
                     search_term = NULL, published = NULL, 
                     server = "test", ...) {
        
        url <- loadURL(server)

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