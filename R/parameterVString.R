#' Make Parameter Vector
#' 
#' Take a string of a parameter name and vector and create a string snipper that 
#' can be used to pass that vector as an array in the url of an http request.
#' @param parameter_name The label of the parameter to be arrayed in the url
#' @param parameter_values The vector of values to be arraye in the url
#' @export

parameterVString <- function(parameter_name, parameter_values) {
        results <- ""
        for (i in parameter_values) {
                results <- paste0(results, "&", parameter_name, "[]=", i) 
        }
        return(results)
}