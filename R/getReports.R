#' Get list of available reports
#' 
#' Get a list of available reports
#' @param uri The base uri of a Canvas installation
#' @param accountID The account ID to retrieve reports from 
#' @param titlenm The title of a specific report.  Leave blank for all reports.  Returns all if named report not avilable.
#' @param link Return vector of download location only.
#' @param ... Optional page options to pass to processRequest
#' @export
getReports <- function(uri, accountID, titlenm = "", link = FALSE, ...) {
        
        ##Build the base url for the request
        ##Add in the api specific parameters
        require(utils)
        urlbase <- sub("uri", uri, "uri/api/v1/accounts/accountID/reports?")
        urlbase <- sub("accountID", accountID, urlbase)

        urlbase <- URLencode(urlbase)
        print(urlbase)
        
        ##Pass the url to the request processor
        results <- processRequest(urlbase, ...)
        
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