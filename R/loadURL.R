#' Load Server URL
#' 
#' Assumes that the following url variables have been set in the .Renviron folder: CanvasUrlProd, 
#' CanvasUrlTest, CanvasUrlBeta.  
#' @param server Either the name of the environment variable for the url, or a provided string beginning with 'http'
#' @return url A character vector of of the url

loadURL <- function(server) {
        
        require(httr)
        
        if (server == "test") {
                server <- "CanvasUrlTest"
        }
        
        if (server == "production") {
                server <- "CanvasUrlProd"
        }
        
        if (server == "beta") {
                server <- "CanvasUrlBeta"
        }
        
        if (grepl("^http\\w{0,1}://", server)) {
                server <- server
        } else if (Sys.getenv(server) == "") {
                stop("Please place a url file in .Renviron")
        } else {
                server <- Sys.getenv(server)
        }

        url <- parse_url(server)
        
        return(url)
}
