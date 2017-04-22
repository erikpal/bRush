#' Upload a course file
#' Upload
#' @param url The base url of a Canvas installation
#' @param courseID Course id to create upload the file to
#' @param name The name of the file upon upload.
#' @param filelocal The path to the file.
#' @param path Path of the folder in course files.
#' @param ... Optional page options to pass to processRequest
#' @export
createFile <- function(url, courseID, name = "", filelocal = "", path = "", ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        url <- parse_url(url)
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

        #url <- parse_url(url)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "UPLOAD", ...)
        
        return(results)
}