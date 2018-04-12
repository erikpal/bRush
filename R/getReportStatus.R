#' Get status of a specific report by ID
#' 
#' Get a list of available reports, with extra options to select just a report download url.
#' @param accountID The account ID to retrieve reports from 
#' @param report_type The report identifier (e.g., outcome_results_csv)
#' @param reportID The id of a specific report request
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

getReportStatus <- function(accountID, report_type, reportID, server = "test", ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/accounts/accountID/reports/report_type/reportID"
        url$path <- sub("accountID", accountID, url$path)
        url$path <- sub("report_type", report_type, url$path)
        url$path <- sub("reportID", reportID, url$path)
        
        ##Pass the url to the request processor
        results <- processRequest(url, ...)
        
        return(results)
}