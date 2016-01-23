#' Make SIS User ID Vector
#' 
#' Take a vector of integers and return an character vector that prepares those
#' SIS IDs to work in place of User IDs
#' @param IDs The vector of SIS User IDs to be modified to work as Course IDs
#' @export

sisUser <- function(IDs) {
        results <- NULL
        for (i in IDs) {
                results <- c(results, (paste0("sis_user_id:", i))) 
        }
        return(results)
}