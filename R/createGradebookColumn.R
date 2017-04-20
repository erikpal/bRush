#' Create a custom grade book column
#' 
#' Create a new custom grade book column for the provided course.
#' @param url The base url of a Canvas installation
#' @param ID Course id to create the page in
#' @param title String of column title.
#' @param position Integer of column position
#' @param hidden Boolean of whether the column is hidden or not
#' @param ... Optional page options to pass to processRequest
#' @export
createGradebookColumn <- function(url, ID, title = NULL, position = 1, 
                       hidden = FALSE) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(httr)
        
        url <- parse_url(url)
        url$path <- "/api/v1/courses/ID/custom_gradebook_columns"
        url$path <- sub("ID", ID, url$path)
        
        ##Build the JSON for the body of the 
        require(jsonlite)
        body <- list(
                column = list(
                         title = title,
                         position = position,
                         hidden = hidden
                )
        )
        body <- toJSON(body, auto_unbox = TRUE)
        
        print(build_url(url))
        print(body)
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE")
        
        return(results)
}