#' Start an account report
#' 
#' Get a list of available reports, with extra options to select just a report download url.
#' @param accountID The account ID to retrieve reports from 
#' @param report_type The report identifier (e.g., outcome_results_csv)
#' @param server Test, beta, production, or other name in R.environ OR full url of server
#' @param ... Optional page options to pass to processRequest
#' @export

startReport <- function(accountID, report_type, server = "test", 
                        enrollment_term_id = NULL,
                        include_deleted = NULL,
                        course_id = NULL,
                        order = NULL,
                        users = NULL,
                        accounts = NULL,
                        terms = NULL,
                        courses = NULL,
                        sections = NULL,
                        enrollments = NULL,
                        groups = NULL,
                        group_categories = NULL,
                        group_memberships = NULL,
                        xlist = NULL,
                        user_observers = NULL,
                        admins = NULL,
                        created_by_sis = NULL,
                        start_at = NULL,
                        end_at = NULL,
                        include_enrollment_state = NULL,
                        enrollment_state = NULL,
                        enrollment_type = NULL,
                        minimum = NULL, ...) {
        
        url <- loadURL(server)
        
        url$path <- "/api/v1/accounts/accountID/reports/report_type"
        url$path <- sub("accountID", accountID, url$path)
        url$path <- sub("report_type", report_type, url$path)
        
        require(jsonlite)
        body <- list(
                parameters = list(
                        enrollment_term_id = enrollment_term_id,
                        include_deleted =include_deleted,
                        course_id = course_id,
                        order = order,
                        users = users,
                        accounts = accounts,
                        terms = terms,
                        courses = courses,
                        sections = sections,
                        enrollments = enrollments,
                        groups = groups,
                        group_categories = group_categories,
                        group_memberships = group_memberships,
                        xlist = xlist,
                        user_observers = user_observers,
                        admins = admins,
                        created_by_sis = created_by_sis,
                        start_at = start_at,
                        end_at = end_at,
                        include_enrollment_state = include_enrollment_state,
                        enrollment_state = enrollment_state,
                        enrollment_type =enrollment_type,
                        minimum = minimum
                )
        )
        
        ##Convert ot JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        
        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}