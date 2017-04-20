#' Load API Token
#' 
#' Assumes that the Canvas API key is in the .Renviron file.  Default name of variable is "CanvasApiKey."
#' If absent, looks in the working directory for txt file with token named token.txt.
#' @param env_var_name Character of the name of the env variable 
#' @return token A character vector of token

loadToken <- function(env_var_name) {
        
        if (Sys.getenv(env_var_name) == "") {
                if ("token.txt" %in% list.files(".")) {
                        con <- file("token.txt", "r")
                        token <- readLines(con, n = 1, warn = FALSE)
                        close(con)
                } else {
                        stop(cat("Please place token file in .Renviron or in working directory as 'token.txt'."))
                }
        } else {
                token <- Sys.getenv(env_var_name) 
        }
        
        return(token)
}