#' Get a single rubric from an account or course
#' 
#' @param ID Integer of the account ID to find users for
#' @param type Course or account
#' @param rubricID ID of the specific rubric
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getRubric <- function(ID, rubricID = "", type = "account", server = "test", ...) {
        
        url <- loadURL(server)
        
        if (type == "account") {
                url$path <- "api/v1/accounts/ID/rubrics/rubricID"
                url$path <- sub("ID", ID, url$path)
        }
        
        if (type == "course") {
                url$path <- "api/v1/courses/ID/rubrics/rubricID"
                url$path <- sub("ID", ID, url$path)
        }
        
        if (!type %in% c("course", "account")) {
                warning('Type must be for "course" or "account" only.')
        }
        
        url$path <- sub("rubricID", rubricID, url$path)
        
        url$query <- list("include[]" = "assessments",
                          "include[]" = "associations")
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}