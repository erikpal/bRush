#' Create a content migration.
#' 
#' Create a content migration with migrator type and a settings list. Does not
#' currently support file uploads.  Limited testing conducted on various migrators.
#' @param url The base url of a Canvas installation
#' @param ID ID of context to import into.
#' @param type String of type - course, account, group, or user
#' @param migration_type String of migrator type
#' @param settings Named list of settings for the migrator
#' @param ... Optional page options to pass to processRequest
#' @export
createMigration <- function(url, ID, type = "course", 
                            migration_type = "course_copy_importer", 
                            settings, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
        
        url$path <- "api/v1/TYPE/ID/content_migrations"
        
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
        
        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list(
                migration_type = migration_type,
                settings = settings
        )
        
        ##Convert ot JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}