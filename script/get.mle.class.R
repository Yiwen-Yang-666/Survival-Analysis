get.mle.class <- function(y.row) 
{
  i <- 1+sum((max(y.row)>cummax(y.row)))
  if (!is.null(names(y.row)[i])) {
    return(names(y.row)[i])
  }
  else return(i)
}