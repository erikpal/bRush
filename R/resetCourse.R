#' Reset a course
#' 
#' Reset a course.
#' @param ID Course id to reset

#' @export

resetCourse <- function(ID, 
                       server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/ID/reset_content"
        url$path <- sub("ID", ID, url$path)
        
        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list()
        
        body <- toJSON(body, auto_unbox = TRUE)
        
        print(build_url(url))
        print(body)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}