#' Get a data frame from an "uneven" list from a get apply
#' 
#' This function can be used to "flatten" a list created from an mapply or lapply 
#' of one of the get tools.  If an apply is used to grab multiple items from
#' multiple sources (e.g. multiple assignments from multiple courses), this will
#' add the missing the variables to all the items retreived and combine them to 
#' a single data frame.
#' @param list The list to return the data frame of.
#' @export

dfFromApply <- function(list) {
        x <- lapply(list, colnames)
        variables <- unique(unlist(lapply(list, colnames)))
        
        for (i in 1:length(list)) {
                newcol <- !variables %in% colnames(list[[i]])
                
                blanks <- matrix(ncol = (length(newcol) - length(list[[i]])), 
                                 nrow = nrow(list[[i]]))
                blanks <- as.data.frame(blanks)
                
                colnames(blanks) <- variables[newcol]
                
                list[[i]] <- cbind(list[[i]], blanks)
        }
        list <- do.call(rbind, list)
        return(list)
}