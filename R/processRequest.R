#' Get Multipage Results
#' 
#' Takes a url constructed for API request, including url parameters to produce one 
#' result from multiple requests across multiple pages.  The parameters of this 
#' function, most likely passed from others, can be used to narrow the results by
#' start and end page, as well as the number of results per page (max. 100). 
#' @param per_page Number of results requested at one time (max: 100)
#' @param page Page number to start requests from
#' @param end_page Page number to end requests
#' @export

##TODO: per_page set to 1 causes problems
processRequest <- function(urlbase, method = "GET", JSONbody,
                           per_page = 100, page = 1, end_page = NULL) {
        require(httr)
        require(jsonlite)
        require(dplyr)
        
        token <- loadToken()##Load  token from text file in the working directory
        header <- paste("Bearer", token)
        
        if (method == "GET") {
                results <- data.frame()
                while (page > 0) {
                        url <- paste0(urlbase, "&page=", page, "&per_page=", per_page)
                        request <- GET(url, add_headers(Authorization = header))
                        status <- http_status(request)
                        
                        ###DEAL WITH SOME ERROR MESSAGES
                        if (status[["category"]] == "server error") {
                                print(status[["message"]])
                                break
                        }
                        if (status[["category"]] == "client error") {
                                print(status[["message"]])
                                break
                        }
                        
                        x <- content(request, as = "text")
                        x <- jsonlite::fromJSON(x, flatten = TRUE)
                        
                        ##fromJSON doesn't convert single items to data frames
                        ##This is a temporary fix for length based issues so that
                        ##the list is passed as results.
                        if (!is.data.frame(x)) {
                                if (length(x) == 0) {
                                        stop("No Results")
                                } else {
                                results <- x
                                break
                                }
                        }
                        
                        results <- bind_rows(results, x)##Build the data through loops
        
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
                
                return(results)
        }
        
        if (method == "EDIT") {
                results <- data.frame()
                ##Add the goods here if an edit function passes
                print(results)
        }
        
        if (method == "CREATE") {
                results <- NULL
                url <- urlbase
                request <- POST(url, 
                                add_headers(Authorization = header),
                                content_type_json(),
                                body = JSONbody)
                status <- http_status(request)   
                
                ###DEAL WITH SOME ERROR MESSAGES
                if (status[["category"]] == "server error") {
                        stop(status[["message"]])
                }
                if (status[["category"]] == "client error") {
                        stop(status[["message"]])
                }    
                
                results <- content(request, as = "text")
                results <- jsonlite::fromJSON(results, flatten = TRUE)

                return(results)
        }
        
        if (method == "UPLOAD") {
                results <- JSONbody
                url <- results$upload_url
                params <- results$upload_params
                params <- c(params, upload_file(results$filename))
                request <- POST(url, 
                                content_type("multipart/form-data"),
                                encode = "multipart",
                                body = params,
                                verbose())
                
                status <- http_status(request)   
                
                ###DEAL WITH SOME ERROR MESSAGES
                if (status[["category"]] == "server error") {
                        stop(status[["message"]])
                }
                if (status[["category"]] == "client error") {
                        stop(status[["message"]])
                }    
                
                results <- content(request, as = "text")
                results <- jsonlite::fromJSON(results, flatten = TRUE)
                
                return(results)
        }
        if (!method %in% c("GET", "CREATE", "EDIT", "UPLOAD")) {
                stop("No viable request method provided for processRequest")
        }
}