#' Upload a course file
#' 
#' Upload a local file to a course.
#' @param courseID Course id to create upload the file to
#' @param name The name of the file upon upload.
#' @param filelocal The path to the file.
#' @param path Path of the folder in course files.
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

createFile <- function(courseID, name = "", filelocal = "", 
                       path = "", server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/courses/courseID/files"
        url$path <- sub("courseID", courseID, url$path)
        
        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list(
                name = name,
                parent_folder_path = path
        )
        body <- toJSON(body, auto_unbox = TRUE)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE")
        
        ##Take the results and append to do the upload
        results$filename <- filelocal 
        body <- results##rename before pass
        url <- results$upload_url

        url <- parse_url(url)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "UPLOAD", ...)
        
        return(results)
}