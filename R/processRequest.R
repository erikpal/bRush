#' Get Multipage Results
#' 
#' Takes a url constructed for API request, including url parameters to produce one 
#' result from multiple requests across multiple pages.  The parameters of this 
#' function, most likely passed from others, can be used to narrow the results by
#' start and end page, as well as the number of results per page (max. 100). 
#' @param per_page Number of results requested at one time (max: 100)
#' @param page Page number to start requests from
#' @param end_page Page number to end requests
#' @param env_var_name Name of the API key saved in .Renviron
#' @param verbose Enable verbose mode
#' @export

##TODO: per_page set to 1 causes problems
processRequest <- function(url, body, method = "GET",
                           per_page = 100, page = 1, end_page = NULL, 
                           env_var_name = "CanvasApiKey", 
                           verbose = FALSE) {
        require(httr)
        require(jsonlite)
        require(dplyr)
        
        token <- loadToken(env_var_name)##Load  token from text file in the working directory
        header <- paste("Bearer", token)
        
        if(verbose == TRUE) {
                print(build_url(url))
        }

        if (method == "GET") {
                results <- list()
                while (page > 0) {
                        url$query <- c(url$query, page = page, per_page = per_page)

                        request <- GET(url, add_headers(Authorization = header))
                        status <- http_status(request)
                        
                        
                        ##Deal with errors
                        checkErrors(status)
                        
                        #For debugging, etc. - make a function and add to other methods
                        if(verbose == TRUE) {
                                print(Sys.time())
                                print(paste("Page:", page))
                                print(paste("Results:", length(content(request))))
                                print(paste("$headers$`x-request-cost`:", request$all_headers[[1]]$headers$`x-request-cost`))
                                print(paste("$headers$`x-rate-limit-remaining`:", request$all_headers[[1]]$headers$`x-rate-limit-remaining`))
                        }
                        
                        x <- content(request, as = "text")
                        x <- jsonlite::fromJSON(x, flatten = TRUE)
                        
                        ##fromJSON doesn't convert single items to data frames
                        ##This is a temporary fix for length based issues so that
                        ##the list is passed as results.
                        if (!is.data.frame(x)) {
                                if (length(x) == 0) {
                                        warning("No Results")
                                } else {
                                        results[[page]] <- x
                                        break
                                }
                        }
                        
                        #results <- bind_rows(results, x)##Build the data frame through loops
                        results[[page]] <- x 
                        
                        ##Check to make sure end page is after start page
                        if (!is.null(end_page)) {
                                if (end_page < page) {stop("Requested end_page is less than the start page.")}
                        }
                        
                        ##If the per_page number is at 100%, then set page +1 for another loop
                        if (length(content(request)) >= per_page) {
                                if (!is.null(end_page)){##If an end page is provided...
                                        if (page == end_page) {##...check to see if we're there
                                                page <- 0
                                        } else {
                                                page <- page + 1
                                        }
                                } else {
                                        page <- page + 1
                                }
                                
                        } else {#Set page to 0 to stop look if per_page is less than 100% full
                                page <- 0
                        }
                }
                
                if (is.data.frame(results[[1]])) {
                        results <- do.call(rbind, results)
                }
                
                return(results)
        }
        
        if (method == "EDIT") {
                results <- NULL
                
                request <- PUT(url, 
                                add_headers(Authorization = header),
                                content_type_json(),
                                body = body)
                status <- http_status(request)   
                
                ##Deal with errors
                checkErrors(status)  
                
                results <- content(request, as = "text")
                results <- jsonlite::fromJSON(results, flatten = TRUE)
                
                return(results)
        }
        
        if (method == "CREATE") {
                results <- NULL

                request <- POST(url, 
                                add_headers(Authorization = header),
                                content_type_json(),
                                body = body)
                status <- http_status(request)   
                
                ##Deal with errors
                checkErrors(status)  
                
                results <- content(request, as = "text")
                results <- jsonlite::fromJSON(results, flatten = TRUE)
                
                return(results)
        }
        
        if (method == "UPLOAD") {
                results <- body##rename after pass
                params <- results$upload_params
                params$file <- upload_file(results$filename)##Add the file name to the needed params
                request <- POST(url, 
                                content_type("multipart/form-data"),
                                encode = "multipart",
                                body = params)

                if (request$all_headers[[2]]$status == 303) {
                        request <- GET(request$url, 
                                       add_headers(Authorization = header))
                }
                
                status <- http_status(request)   
                
                ##Deal with errors
                checkErrors(status) 
                
                results <- content(request, as = "text")
                results <- jsonlite::fromJSON(results, flatten = TRUE)
                
                return(results)
        }
        
        if (!method %in% c("GET", "CREATE", "EDIT", "UPLOAD")) {
                stop("No viable request method provided for processRequest")
        }
}