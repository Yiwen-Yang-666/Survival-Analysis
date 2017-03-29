pamr.cv.cox <- function(data, cur.tt, n.step=100, lower=quantile(cur.tt,.97),
                        upper=quantile(cur.tt,1-(2/nrow(data$x)))) 
{
  require(survival)
  require(pamr)
  th <- seq(from=lower, to=upper, length=n.step)
  best.chisq <- -Inf
  best.err <- Inf
  for (i in 1:n.step) {
  
    print(i)
    cur.genes <- (cur.tt>th[i])
    cur.y <- kmeans2(t(data$x[cur.genes,]), 2)$cluster
    cur.chisq <- survdiff(Surv(data$y, data$icens)~cur.y)$chisq
    if (cur.chisq > best.chisq) {
      cur.trn <- pamr.train(list(x=data$x, y=cur.y))
      cur.cv <- pamr.cv(cur.trn, list(x=data$x, y=cur.y))
      cur.best.err <- min(cur.cv$error)
      best.i <- max((1:30)[cur.cv$error==cur.best.err])
      if (cur.best.err < best.err) {
        best.th <- th[i]
        best.trn <- cur.trn
        best.cv <- cur.cv
        best.chisq <- cur.chisq
        best.err <- cur.best.err
      }
    }
  }
  junk <- list(th=best.th, model.trn=best.trn, model.cv=best.cv)
  return(junk)
}