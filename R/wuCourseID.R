#' Make a WU SIS course ID base from arguments
#' 
#' Take a vector of integers and return an character vector that prepares those
#' SIS IDs to work in place of User IDs
#' @param coure The prefix, course, section, term and year with spaces
#' @param dept The college/school and department
#' @param div Web enhanced or online?
#' @export
wuCourseID <- function(course = "", dept = "", div = "WE") {
        
        if (dept == "") {
                if (grepl("BUSN", course) == TRUE) {dept <- "BUSN MNGT"}
                if (grepl("MNGT", course) == TRUE) {dept <- "BUSN MNGT"}
                ##Need to provide the dept argument until this complete
        }
        
        id <- paste0(div, " ", dept, " ", course)
        id <- gsub(" ", "_", id, fixed = TRUE)
        
        return(id)
}