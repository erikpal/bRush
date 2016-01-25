#' Upload a course file
#' Upload
#' @param uri The base uri of a Canvas installation
#' @param ID Course id to create upload the file to
#' @param name The name of the file upon upload.
#' @param filelocal The path to the file.
#' @param path Path of the folder in course files.
#' @param ... Optional page options to pass to processRequest
#' @export
uploadFile <- function(uri, ID, name = "", filelocal = "", path = "") {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/courses/ID/files?")
        urlbase <- sub("ID", ID, urlbase)
        
        ##Build the JSON for the body of the 
        require(jsonlite)
        JSONbody <- list(
                name = name,
                parent_folder_path = path
        )
        JSONbody <- toJSON(JSONbody, auto_unbox = TRUE)
        
        urlbase <- URLencode(urlbase)
        
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, JSONbody, method = "CREATE")
        
        results$filename <- filelocal 
        JSONbody <- results

        ##Pass the url to the request processor
        results <- processRequest(urlbase, JSONbody, method = "UPLOAD")
        
        return(results)
}