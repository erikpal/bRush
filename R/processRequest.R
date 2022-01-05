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
#' @param as_user_id User id for masquerading
#' @param verbose Enable verbose mode
#' @export

##TODO: per_page set to 1 causes problems
processRequest <- function(url, body, method = "GET",
                           env_var_name = "CanvasApiKey", 
                           as_user_id = NULL,
                           verbose = FALSE) {
        require(httr)
        require(jsonlite)
        require(dplyr)
        
        ## Masquerade
        if(!is.null(as_user_id)) {
                url$query$as_user_id <- as_user_id
        }
        
        token <- loadToken(env_var_name)##Load  token from text file in the working directory
        header <- paste("Bearer", token)
        
        if(verbose == TRUE) {
                print(build_url(url))
        }

        if (method == "GET") {
                
                results <- list()
                continue <- TRUE
                page <- 0
                
                while (continue == TRUE) {
                        
                        page <- page + 1
                        
                        response <- GET(url, add_headers(Authorization = header))
                        status <- http_status(response)
                        
                        ##Deal with errors
                        checkErrors(status)
                        
                        if(verbose == TRUE) {bRushVerbose(response)}
                        
                        content <- content(response, as = "text")
                        #test <<- content
                        content <- jsonlite::fromJSON(content, flatten = TRUE)
                        
                        resultkey <- tryCatch({
                                suppressMessages({
                                        content <- as.data.frame(content)
                                })
                        }, 
                        error = function(e) {
                                NA_character_
                        }
                        )

                        ##fromJSON doesn't convert single items to data frames
                        ##This is a temporary fix for length based issues so that
                        ##the list is passed as results.
                        ##
                        ## UPDATE: This breaks non-rectangular, multi-page results
                        ## Turning off to find a way to test wiht getUserProfile
                        # if (!is.data.frame(content)) {
                        #         if (length(content) == 0) {
                        #                 #warning("No Results")
                        #                 break
                        #         } else {
                        #                 results[[page]] <- content
                        #                 break
                        #         }
                        # }
                        
                        results[[page]] <- content
                        
                        if(is.null(response$headers$link)) {break}
                        
                        page_links <- paginationLinks(response)

                        if ("next" %in% names(page_links)) {
                                url <- page_links[["next"]]
                        } else {
                                continue <- FALSE
                        }
                        
                }
                
                if (is.data.frame(results[[1]])) {
                        
                        ## Identify columns that are logical in one frame and
                        ## character in another
                        logichars <- results %>% 
                                map(~map(.x, ~typeof(.x)) %>% 
                                            unlist() %>%
                                            tibble(name = names(.), value = .)) %>% 
                                bind_rows() %>% 
                                distinct() %>% 
                                filter(value %in% c("logical", "character")) %>% 
                                group_by(name) %>%
                                filter(n() > 1) %>% 
                                select(name) %>% 
                                distinct() %>% 
                                pull(name)

                        results <- results %>% 
                                map(~mutate(.x, across(any_of(logichars), as.character))) %>%
                                bind_rows()
                        #results <- do.call(rbind, results)
                        #row.names(results) <- NULL
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
                
                if(verbose == TRUE) {bRushVerbose(request)}
                
                results <- content(request, as = "text")
                results <- jsonlite::fromJSON(results, flatten = TRUE)
                
                return(results)
        }
        
        if (method == "CREATE") {
                results <- NULL

                response <- POST(url, 
                                add_headers(Authorization = header),
                                content_type_json(),
                                body = body)
                status <- http_status(response)   
                
                ##Deal with errors
                checkErrors(status)  
                
                if(verbose == TRUE) {bRushVerbose(response)}
                
                results <- content(response, as = "text")
                results <- jsonlite::fromJSON(results, flatten = TRUE)
                
                return(results)
        }
        
        if (method == "UPLOAD") {
                results <- body##rename after pass
                params <- results$upload_params
                params$file <- upload_file(results$filename)##Add the file name to the needed params
                response <- POST(url, 
                                content_type("multipart/form-data"),
                                encode = "multipart",
                                body = params)
                
                status <- http_status(response)   
                
                ##Deal with errors
                checkErrors(status) 
                
                if(verbose == TRUE) {bRushVerbose(response)}
                
                # if (response$all_headers[[2]]$status == 303) {
                #         ##This thsrd step is returning a bad request and I can't figure out why
                #         url <-  response$all_headers[[2]]$headers$location
                #         url <- parse_url(url)
                #         response <- POST(url, add_headers(Authorization = header))
                #         status <- http_status(response)   
                #         checkErrors(status) 
                #         if(verbose == TRUE) {bRushVerbose(response)}
                # }
                
                ##Until the third step is working
                ##results <- content(response, as = "text")
                ##results <- jsonlite::fromJSON(results, flatten = TRUE)
                ##return(results)
                
                return(response)
                
        }
        
        if (!method %in% c("GET", "CREATE", "EDIT", "UPLOAD")) {
                stop("No viable request method provided for processRequest")
        }
}