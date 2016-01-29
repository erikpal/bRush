#' Check for Errors
#' 
#' Used by processRequest to stop if there are http errors.
#' @param status http status passed by process request.
#' @export

checkErrors <- function(status) {
        if (status[["category"]] == "server error") {
                stop(status[["message"]])
        }
        if (status[["category"]] == "client error") {
                stop(status[["message"]])
        }
}