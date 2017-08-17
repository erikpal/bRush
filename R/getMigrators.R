#' List migrators
#' 
#' Get terms in a specified account.
#' @param url The base url of a Canvas installation
#' @param ID Integer of the account ID to find sub-accounts for
#' @param type String of type - course, account, group, or user
#' @param ... Optional page options to pass to processRequest
#' @export

##I can't test this one since I don't have manage privileges for the root account.
##Applied to a subaccount, it redirects to the root and returns an error.
##The error is not JSON data so it doesn't work, further testing with access needed

getMigrators <- function(url, ID, type = "course", ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        
        require(httr)
        url <- parse_url(url)
        
        url$path <-  "api/v1/TYPE/ID/content_migrations/migrators"
        
        if(type == "course"){
                url$path <- sub("TYPE", "courses", url$path)
        }
        
        if(type == "account"){
                url$path <- sub("TYPE", "accounts", url$path)
        }
        
        if(type == "group"){
                url$path <- sub("TYPE", "groups", url$path)
        }
        
        if(type == "user"){
                url$path <- sub("TYPE", "users", url$path)
        }
        
        url$path <- sub("ID", ID, url$path)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}