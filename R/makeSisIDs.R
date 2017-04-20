#' Make SIS ID Vector
#' 
#' Take a vector of integers and return an character vector that prepares those
#' SIS IDs to work in place of User IDs
#' @param IDs The vector of IDs to be modified to work as supplied id type
#' @param type A character vector of the id type to create (account, course, user, term)
#' @export

makeSisIDs <- function(sisids, type = "course") {
        results <- as.character()
        for (i in sisids) {
                results <- c(results, (paste0("sis_", type, "_id:", i))) 
        }
        return(results)
}