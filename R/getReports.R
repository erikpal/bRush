#' Get list of available reports
#' 
#' Get a list of available reports, with extra options to select just a report download url.
#' @param accountID The account ID to retrieve reports from 
#' @param titlenm The title of a specific report.  Leave blank for all reports.  Returns all if named report not avilable.
#' @param link Return vector of download location only.
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getReports <- function(accountID, titlenm = "", link = FALSE, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "api/v1/accounts/accountID/reports"
        url$path <- sub("accountID", accountID, url$path)

        url$query <- list(exclude = NULL)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        if (titlenm %in% results$title) {
                results <- filter(results, title == titlenm)
        }
                
        if (link == TRUE) {
                results <- results[["last_run.attachment.url"]]
                results <- results[!is.na(results)]
        }
        
        ##if (length(results) == 0 & !reportNM == "") {print("Length is zero, check report name.")}
        return(results)
}