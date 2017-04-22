#' Verbose console output
#' 
#' For debugging, etc., outputs informations after each API request
#' @param response http response object.
#' @export

bRushVerbose <- function(response) {
        print(Sys.time())
        print(paste("Results:", length(content(response))))
        print(paste("$headers$`x-request-cost`:", response$all_headers[[1]]$headers$`x-request-cost`))
        print(paste("$headers$`x-rate-limit-remaining`:", response$all_headers[[1]]$headers$`x-rate-limit-remaining`))
}