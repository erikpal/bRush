#' Create a content export
#' 
#' Create a new content export.
#' @param ID ID of context to import into.
#' @param type Type - course, group, or user
#' @param export_type Export type - common_cartridge, qti, zip
#' @param skip_notifications Notify the user of the export creation
#' @param select Named list of object types and the IDs to include
#' @param server Test, beta, prodcution, OR alternative name in R.environ OR url of server
#' @param ... Optional page options to pass to processRequest
#' @export

createContentExport <- function(ID, 
                                export_type,
                                type = "course", 
                                skip_notifications = TRUE,
                                select = NULL, 
                                server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <-  "api/v1/TYPE/ID/content_exports"
        
        if(type == "course"){
                url$path <- sub("TYPE", "courses", url$path)
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
                export_type = export_type,
                skip_notifications = skip_notifications,
                select = select
        )
        
        ##Convert ot JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}