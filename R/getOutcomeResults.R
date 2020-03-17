#' Get the results of the outcomes for the students
#' 
#' @param ID Course ID of the outcome
#' @param userIDs User IDs of the students
#' @param outcomeIDs Outcome IDs of the outcomes
#' @param include Options to include in the results
#' @param include_hidden Boolean to include results hidden from learning mastery gradebook
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export
getOutcomeResults <- function(ID,
                              include = c("alignments", "outcomes", "outcomes.alignments", 
                                          "outcome_groups", "outcome_links", "outcome_paths", 
                                          "users"), 
                              include_hidden = TRUE,
                              server = "test", ...){
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/courses/ID/outcome_results"        
        url$path <- sub("ID", ID, url$path)

        include_list <- as.list(include)
        names(include_list) <- rep("include[]", length(include_list))
        
        url$query <- c(include_list,
                       list(include_hidden = include_hidden))
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}