#' Get enrollments for an section, course, or user
#' 
#' Get enrollments for a course, section, or user
#' @param ID ID to find enrollments for
#' @param type Use "course", "account", or "user"
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getEnrollments <- function(ID, type = "course", server = "test", ...) {
        
        url <- loadURL(server)
        
        if(type %in% c("course", "section", "user")) {
                type <- paste0(type, "s")
        } else {
                stop("Invalid type for enrollments")
        }
        
        url$path <- "api/v1/TYPE/ID/enrollments"
        url$path <- sub("ID", ID, url$path)
        url$path <- sub("TYPE", type, url$path)
        
        url$query <- list("include[]" = "group_ids",
                          "include[]" = "avatar_url",
                          "include[]" = "locked",
                          "include[]" = "observed_users",
                          "include[]" = "can_be_removed",
                          "include[]" = "uuid",
                          "include[]" = "current_points"
                          )
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}