#' Extract Pagination Links
#' 
#' Extract the links from the headers as named objects.
#' @param response http response object.
#' @export

paginationLinks <- function(response) {
        
        links <- response$headers$link
        ##if (is.null(links)) {break}
        
        pagination <- c("current" = 'rel=\"current\"',
                        "next" = 'rel=\"next\"',
                        "first" = 'rel=\"first\"',
                        "last" = 'rel=\"last\"')
        
        links_split <- strsplit(links, ",")
        links_split <- unlist(links_split)
        
        page_links <- list()
        
        n <- 0
        for (a in pagination) {
                n <- n + 1
                page_links[[names(pagination[n])]] <- links_split[grepl(a, links_split)]
        }
        
        page_links <- unlist(page_links)
        
        page_links <- gsub("<(.*)>(.*$)", "\\1", page_links)
        
        return(page_links)
}


