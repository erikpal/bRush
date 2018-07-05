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
        body <- NULL
        body$parameters <- NULL
                if(!is.null(enrollment_term_id)){body$parameters$enrollment_term_id = enrollment_term_id}
                if(!is.null(include_deleted)){body$parameters$include_deleted = include_deleted}
                if(!is.null(course_id)){body$parameters$course_id = course_id}
                if(!is.null(order)){body$parameters$order = order}
                if(!is.null(users)){body$parameters$users = users}
                if(!is.null(accounts)){body$parameters$accounts = accounts}
                if(!is.null(terms)){body$parameters$terms = terms}
                if(!is.null(courses)){body$parameters$courses = courses}
                if(!is.null(sections)){body$parameters$sections = sections}
                if(!is.null(enrollments)){body$parameters$enrollments = enrollments}
                if(!is.null(groups)){body$parameters$groups = groups}
                if(!is.null(group_categories)){body$parameters$group_categories = group_categories}
                if(!is.null(group_memberships)){body$parameters$group_memberships = group_memberships}
                if(!is.null(xlist)){body$parameters$xlist = xlist}
                if(!is.null(user_observers)){body$parameters$user_observers = user_observers}
                if(!is.null(admins)){body$parameters$admins = admins}
                if(!is.null(created_by_sis)){body$parameters$created_by_sis = created_by_sis}
                if(!is.null(start_at)){body$parameters$start_at = start_at}
                if(!is.null(end_at)){body$parameters$end_at = end_at}
                if(!is.null(include_enrollment_state)){body$parameters$include_enrollment_state = include_enrollment_state}
                if(!is.null(enrollment_type)){body$parameters$enrollment_type = enrollment_type}
                if(!is.null(minimum)){body$parameters$enrollment_type = minimum}

        ##Convert ot JSON
        body <- jsonlite::toJSON(body, auto_unbox = TRUE, POSIXt = "ISO8601")
        bodyx <<- body

        ##Pass the url to the request processor
        results <- processRequest(url, body, method = "CREATE", ...)
        
        return(results)
}