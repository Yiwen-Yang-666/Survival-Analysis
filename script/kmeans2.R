kmeans2 <- function(x, ..., n.rep=10) 
{
  require(cluster)
  wss <- Inf
  for (i in 1:n.rep) {
    cur.fit <- kmeans(x, ...)
    if (sum(cur.fit$withinss) < wss) {
      fit <- cur.fit
      wss <- sum(fit$withinss)
    }
  }
  return(fit)
}