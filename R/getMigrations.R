#' List migrations
#' 
#' List content migrations.
#' @param ID Integer of the account ID to find sub-accounts for
#' @param type String of type - course, account, group, or user
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getMigrations <- function(ID, type = "course", server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <-  "api/v1/TYPE/ID/content_migrations"
        
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