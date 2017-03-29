find.surv.ndx <- function(newtimes, oldtimes) 
{
  first <- apply(as.matrix(newtimes), 1, function(e1,e2) (e1>=e2), e2=oldtimes)
  as.vector(apply(first, 2, sum))
  
}