#' Load API Token
#' 
#' Looks in the working directory for txt file with token.
#' @return token A character vector of token

loadToken <- function() {
        if ("token.txt" %in% list.files(".")) {
                con <- file("token.txt", "r")
                token <- readLines(con, n = 1, warn = FALSE)
                close(con)
        } else {
                stop("Please place token file in working directory as 'token.txt'.")
        }
        return(token)
}