#' Get a list of external tools used ina course
#' 
#' Get a list of pages in course or group.
#' @param ID Account, course or group ID to list external tools in
#' @param type Account, course or group
#' @param search_term Filter results by partial title. Must be at least 3 characters.
#' @param selectable If true, then only tools that are meant to be selectable are returned
#' @param include_parents If true, then include tools installed in all accounts above the current context
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getExternalTools <- function(ID, type = "course", search_term = NULL,
                            selectable = NULL, include_parents = NULL,
                            server = "test", ...) {
        
        url <- loadURL(server)
        
        if (type == "course"){type <- "courses"}
        if (type == "account"){type <- "accounts"}
        if (type == "group"){type <- "groups"}
        
        
        url$path <- "api/v1/TYPE/ID/external_tools"
        url$path <- sub("TYPE", type, url$path)
        url$path <- sub("ID", ID, url$path)
        
        url$query <- list(search_term = search_term,
                          selectable = selectable,
                          include_parents = include_parents)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}